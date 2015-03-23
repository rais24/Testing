
namespace :rubber do

  namespace :unicorn do
    unicorn_pid_file = "/var/run/unicorn.pid"
    rubber.allow_optional_tasks(self)
    
    before "deploy:stop", "rubber:unicorn:stop"
    after "deploy:start", "rubber:unicorn:start"
    after "deploy:restart", "rubber:unicorn:reload"
    
    desc "Stops the unicorn server"
    task :stop, :roles => :unicorn do
      # if the PID file is there, cleanup the PID file,
      # then kill the process
      rsudo <<-STOP.gsub(/^ {8}/, '')
        if [ -f #{unicorn_pid_file} ]; then
          PID=`cat #{unicorn_pid_file}`;
          rm -f #{unicorn_pid_file};
          ! [ -z "$PID" ] && kill -TERM $PID;
        fi
      STOP
    end
    
    desc "Starts the unicorn server"
    task :start, :roles => :unicorn do
      rsudo <<-START.gsub(/^ {8}/, '')
        cd #{current_path} && 
          bundle exec unicorn -c #{current_path}/config/unicorn.rb -E #{Rubber.env} -D
      START
    end
    
    desc "Restarts the unicorn server"
    task :restart, :roles => :unicorn do
      stop
      start
    end

    desc "Reloads the unicorn web server"
    task :reload, :roles => :unicorn do
      rsudo "if [ -f #{unicorn_pid_file} ]; then pid=`cat #{unicorn_pid_file}` && kill -USR2 $pid; else cd #{current_path} && bundle exec unicorn -c #{current_path}/config/unicorn.rb -E #{Rubber.env} -D; fi"
    end

    desc "Display status of the unicorn web server"
    task :status, :roles => :unicorn do
      # "service unicorn status" always returns "unicorn stop/waiting"
      rsudo "ps -eopid,user,cmd | grep [u]nicorn || true"
      rsudo "netstat -tupan | grep unicorn || true"
    end
  end
end