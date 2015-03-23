namespace :db do
  namespace :dev do
    desc "Seed the DB with development data"
    task seed: :environment do
      # If you're not in production, populate the DB with some 
      # development data
      puts "Seeding development data..."
      seed_file = File.join("db", "dev.rb")
      load(seed_file) if File.exist?(seed_file)
    end
  end
end