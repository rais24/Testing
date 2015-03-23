def ssh(cmd, with_tty = false)
  hostname  = find_servers_for_task(current_task).first
  setup     = "source /etc/profile && source ~/.bashrc"
  tty       = with_tty ? '-t' : ''
  key       = "~/.ec2/gsg-keypair"

  exec "ssh -i #{key} #{user}@#{hostname} #{tty} '#{setup} && #{cmd}'"
end

def replicate_cmd(name, env = {})
  config    = "./config/environment"
  script    = "./config/replicate/dump-#{name}.rb"
  setup     = env.map { |k,v| "#{k}=#{v}" }.join(' ')
  hostname  = find_servers_for_task(current_task).first

  dump = ssh """
  cd #{current_path}
  #{setup} replicate -r #{config} -d #{script}
  """
  system "bin/replicate -r ./config/environment -l '#{dump}'"
end

desc "Open the rails console on one of the remote servers"
task :console, roles: :app do
  ssh "cd #{current_path} && ./bin/rails c #{rails_env}", true
end

namespace :replicate do
  desc "Replicate the production data for a Delivery Site"
  task :site, roles: :app do
    limit = ENV['LIMIT'] || 20
    site  = ENV['SITE']
    replicate_cmd :site, LIMIT: limit, SITE: site
  end
end