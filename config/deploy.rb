# This is a sample Capistrano config file for rubber

# set :stages, %w(staging production)
# set :default_stage, "staging"
# require 'capistrano/ext/multistage'

set :rails_env, Rubber.env

on :load do
  set :application, rubber_env.app_name
  set :runner,      rubber_env.app_user
  set :deploy_to,   "/mnt/#{application}-#{Rubber.env}"
  set :copy_exclude, [".git/*", ".bundle/*", "log/*", ".rvmrc", ".rbenv-version"]
end

# Use a simple directory tree copy here to make demo easier.
# You probably want to use your own repository for a real app
default_run_options[:pty] = true

set :scm, "git"
set :repository, "git@github.com:fitly/fitly-rails.git"
set :deploy_via, :remote_cache
set :branch, defined?(branch) ? branch : "master"
set :ssh_options, { forward_agent: true }

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

# Easier to do system level config as root - probably should do it through
# sudo in the future.  We use ssh keys for access, so no passwd needed
set :user, 'root'
set :password, nil

# Use sudo with user rails for cap deploy:[stop|start|restart]
# This way exposed services (mongrel) aren't running as a privileged user
set :use_sudo, true

# How many old releases should be kept around when running "cleanup" task
set :keep_releases, 3

# Lets us work with staging instances without having to checkin config files
# (instance*.yml + rubber*.yml) for a deploy.  This gives us the
# convenience of not having to checkin files for staging, as well as 
# the safety of forcing it to be checked in for production.
set :push_instance_config, Rubber.env != 'production'

# don't waste time bundling gems that don't need to be there 
set :bundle_without, [:development, :test, :staging] if Rubber.env == 'production'

# Allow us to do N hosts at a time for all tasks - useful when trying
# to figure out which host in a large set is down:
# RUBBER_ENV=production MAX_HOSTS=1 cap invoke COMMAND=hostname
max_hosts = ENV['MAX_HOSTS'].to_i
default_run_options[:max_hosts] = max_hosts if max_hosts > 0

# Allows the tasks defined to fail gracefully if there are no hosts for them.
# Comment out or use "required_task" for default cap behavior of a hard failure
rubber.allow_optional_tasks(self)

# Wrap tasks in the deploy namespace that have roles so that we can use FILTER
# with something like a deploy:cold which tries to run deploy:migrate but can't
# because we filtered out the :db role
namespace :deploy do
  rubber.allow_optional_tasks(self)
  tasks.values.each do |t|
    if t.options[:roles]
      task t.name, t.options, &t.body
    end
  end
end

namespace :deploy do
  after "deploy:setup", "deploy:env:setup"
  after "deploy:update_code", "deploy:db:setup"

  namespace :env do
    desc "Setup the ENV variables"
    task :setup do
      dest = "/etc/profile.d/fitly-env.sh"
      template = File.read(File.join("lib", "templates", "deploy", "fitly-env.sh.erb"))
      result = ERB.new(template).result(binding)
      put result, dest
      run "source #{dest}"
    end
  end

  desc "ping the server"
  task :ping, roles: [:app] do
    instance_filters = ENV['FILTER']
    # if the FILTER=xxxx is present, 
    # parse the instance ALIASes and create a domain
    if instance_filters && !instance_filters.empty?
      aliases = Rubber::Util::parse_aliases(instance_filters)
      hosts = aliases.map do |aliased_host|
        "#{aliased_host}.#{rubber_env.domain}"
      end
    # otherwise, grab the domains of all
    # machines with the :app role
    else
      hosts = rubber_instances.map do |instance_item|
        # grab each role and turn it into a symbol
        roles = instance_item.roles.map(&:name).map(&:to_sym)
        if roles.include? :app
          instance_item.external_host
        end
      end
    end

    # ping each host
    hosts.each do |host|
      puts "Pinging #{host}..."
      system "curl http://#{host} > /dev/null"
    end
  end

  namespace :db do
    desc "Generate the new config/database.yml"
    task :setup do
      template = File.read(File.join("lib", "templates", "deploy","database.yml"))
      # result = ERB.new(template).result(binding)
      # put result, "#{current_path}/config/database.yml"
      put template, "#{release_path}/config/database.yml"
    end
  end

  namespace :assets do
    rubber.allow_optional_tasks(self)
    tasks.values.each do |t|
      if t.options[:roles]
        task t.name, t.options, &t.body
      end
    end
  end
end

# after deploying to an :app instance, ping it
after "deploy", "deploy:ping"

# load in the deploy scripts installed by vulcanize for each rubber module
Dir["#{File.dirname(__FILE__)}/rubber/deploy-*.rb"].each do |deploy_file|
  load deploy_file
end

# capistrano's deploy:cleanup doesn't play well with FILTER
after "deploy", "cleanup"
after "deploy:migrations", "cleanup"
task :cleanup, :except => { :no_release => true } do
  count = fetch(:keep_releases, 5).to_i
  
  rsudo <<-CMD
    all=$(ls -x1 #{releases_path} | sort -n);
    keep=$(ls -x1 #{releases_path} | sort -n | tail -n #{count});
    remove=$(comm -23 <(echo -e "$all") <(echo -e "$keep"));
    for r in $remove; do rm -rf #{releases_path}/$r; done;
  CMD
end

if Rubber::Util.has_asset_pipeline?
  # load asset pipeline tasks, and reorder them to run after
  # rubber:config so that database.yml/etc has been generated
  load 'deploy/assets'
  callbacks[:after].delete_if {|c| c.source == "deploy:assets:precompile"}
  callbacks[:before].delete_if {|c| c.source == "deploy:assets:symlink"}
  before "deploy:assets:precompile", "deploy:assets:symlink"
  before "rubber:config", "deploy:create_symlink"
  after "rubber:config", "deploy:assets:precompile"
end
