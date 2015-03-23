require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Fitly
  class Application < Rails::Application
    #config.middleware.use Rack::WWW, www: false

    # Settings specified here will take precedence over those in config/application.rb
    config.lograge.enabled = false

    config.roadie.enabled

    config.x.sidekiq.clear = true
    config.x.redis.url = ENV['REDISTOGO_URL']

    config.x.better_errors.enable = false


    config.x.stripe.public = ENV['STRIPE_TEST_PUBLIC']
    config.x.stripe.private = ENV['STRIPE_TEST_SECRET']

    config.x.mailchimp.api_key = ENV['MAILCHIMP_API_KEY']
    config.x.mailchimp.timeout = ENV['MAILCHIMP_TIMEOUT']
    config.x.mailchimp.throws_exceptions = ENV['MAILCHIMP_THROWS_EXCEPTIONS']

    # Change mail delvery to either :smtp, :sendmail, :file, :test
    config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #   address: "smtp.gmail.com",
    #   port: 587,
    #   domain: "fitly.org",
    #   authentication: "plain",
    #   enable_starttls_auto: true,
    #   user_name: ENV["FITLY_MAIL_USERNAME"],
    #   password: ENV["FITLY_MAIL_PASSWORD"]
    # }

    # Disable generation of helpers, javascripts, css, and view specs
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.view_specs false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths << File.join(Rails.root, "lib")

    %w(workers services).each do |dir|
      config.autoload_paths << File.join(Rails.root, "app", dir)
    end

    %w(models controllers).each do |dir|
      config.autoload_paths << File.join(Rails.root, "app", dir, "concerns")
    end

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Add the fonts path
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.force_ssl = false
  end
end
