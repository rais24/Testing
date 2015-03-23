namespace :sync do
  def interesting_tables(quick=nil)
    interesting_array = ["sessions", "order_billings", "schema_migrations"]

    ActiveRecord::Base.connection.tables.sort.reject! do |tbl|
      interesting_array.include?(tbl)
    end
  end

  desc "Save amazons rds db"
  task :amazon_to_local => [:environment] do
    user = "fitly"
    pwd = "fitlyfamily215"
    host = "fitly-production.cionvjwbv72r.us-east-1.rds.amazonaws.com"
    db = "fitlydb"
    tables = interesting_tables.join(" ")

    sh "mysqldump -u #{user} -p#{pwd} --no-create-db --no-create-info -h #{host} #{db} #{tables} | gzip -c > db/backup/#{name}.sql.gz"
  end

  desc "Synchronize data on production into data on localhost"
  task :production_to_localhost => [:environment] do
    unless Rails.env == "production"
      user = "b244cbb35a8ecd"
      pwd = "458e7b50"
      host = "us-cdbr-east-05.cleardb.net"
      db = "heroku_2a368bef68fe82a"
      loc = "db/backup"
      name = Time.zone.now.strftime("%Y-%m-%d_%H-%M-%S")
      tables = interesting_tables.join(" ")

      sh "mysqldump -u #{user} -p#{pwd} --no-create-db --no-create-info -h #{host} #{db} #{tables} | gzip -c > db/backup/#{name}.sql.gz"
      sh "chmod 777 db/backup/#{name}.sql.gz"
      sh "rake db:drop"
      sh "rake db:create"
      sh "rake db:migrate"

      db_config = ActiveRecord::Base.configurations[Rails.env]
      sh "gunzip < db/backup/#{name}.sql.gz | mysql --user #{db_config['username']} --password=#{db_config['password']} --socket=#{db_config['socket']} --host=#{db_config['host']} #{db_config['database']}"
      #puts "Updating images for published recipes"
      #sh "rake images:to_localhost"
      #sh "rsync --copy-links --recursive --times --rsh=ssh --compress --human-readable --progress #{user}@#{server}:#{path}/public/shared/ public/shared" if images
    else
      puts "REFUSING TO RUN THIS COMMAND IN PRODUCTION!"
    end
  end
  
  desc "Synchronize data on production into staging"
  task :staging_to_localhost => [:environment] do
    unless Rails.env == "production"
      user = "bc72272b1a7d6a"
      pwd = "aa3e7aa9"
      host = "us-cdbr-east-05.cleardb.net"
      db = "heroku_0a71ae2f94e0018"
      loc = "db/backup"
    
      name = Time.zone.now.strftime("%Y-%m-%d_%H-%M-%S")
      tables = interesting_tables.join(" ")
    
      sh "mysqldump -u #{user} -p#{pwd} --no-create-db --no-create-info -h #{host} #{db} #{tables} | gzip -c > db/backup/#{name}.sql.gz"
      sh "chmod 777 db/backup/#{name}.sql.gz"
      sh "rake db:drop"
      sh "rake db:create"
      sh "rake db:migrate"

      db_config = ActiveRecord::Base.configurations[Rails.env]
      sh "gunzip < db/backup/#{name}.sql.gz | mysql --user #{db_config['username']} --password=#{db_config['password']} --socket=#{db_config['socket']} --host=#{db_config['host']} #{db_config['database']}"
      #puts "Updating images for published recipes"
      #sh "rake images:to_localhost"
      #sh "rsync --copy-links --recursive --times --rsh=ssh --compress --human-readable --progress #{user}@#{server}:#{path}/public/shared/ public/shared" if images
    else
      puts "REFUSING TO RUN THIS COMMAND IN PRODUCTION!"
    end
  end
end
