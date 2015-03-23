require 'dotenv'
# Load up any ENV overrides
Dotenv.load
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'sidekiq/testing/inline'
require 'capybara/rspec'
require 'factory_girl_rails'
require 'paperclip/matchers'
require 'money-rails/test_helpers'
require 'monetize/core_extensions'
require 'email_spec'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

%w(controllers models).each do |dir|
  Dir[Rails.root.join("spec/#{dir}/concerns/*.rb")].each { |f| require f }
end

RSpec.configure do |config|
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers
  config.include MailerMacros

  config.include Features::SessionHelpers, type: :feature

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    clear_emails
    DatabaseCleaner.start
  end

  config.after(:each) do
    Billing.all.each do |billing|
      begin
        Billing.delete_customer!(billing)
      rescue

      end
    end
    DatabaseCleaner.clean
  end
  

  config.infer_spec_type_from_file_location!

  # According to:
  # http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
