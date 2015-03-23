Fitly::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  unless ENV['IMAGE_MAGICK_HOME']
    abort "Please set the IMAGE_MAGICK_HOME environment variable. Try adding it to the .env file!"
  end

  Paperclip.options[:command_path] = ENV['IMAGE_MAGICK_HOME']

  config.x.better_errors.enable = true

  config.middleware.insert_after(ActionDispatch::Static, Rack::LiveReload)

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = {
   host: "localhost",
   port: 3000,
   :domain => "localhost"
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
