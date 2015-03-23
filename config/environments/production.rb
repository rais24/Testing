Fitly::Application.configure do

  config.x.sidekiq.clear = false
  config.x.redis.url = ENV['REDISTOGO_URL']

  config.x.stripe.public = ENV['STRIPE_PUBLIC']
  config.x.stripe.private = ENV['STRIPE_SECRET']

  #config.x.stripe.public = 'pk_test_aXFJfvLmzy1cMlFmr8b3ADIa'
  #config.x.stripe.private = 'sk_test_IFM23pRjSOpSRbQHy691O2Tg'

  # since the Landing page (app/stylesheets/signup and app/javascripts/signsup)
  # is a different asset set, we must allow for asset compilation inline
  config.assets.compile = true

  config.assets.initialize_on_precompile=false

  # Settings specified here will take precedence over those in config/application.rb
  config.lograge.enabled = true

  # Code is not reloaded between requests
  config.cache_classes = true

  # Eager load code on boot. This eager loads most
  # your application in memory, allowing both thre
  # and those relying on copy on write to perform
  # Rake tasks automatically ignore this option fo
  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache
  # Add `rack-cache` to your Gemfile before enabling
  # For large-scale production use, consider using
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  config.paperclip_defaults = {
    storage: :s3,
    s3_protocol: :https,
    s3_credentials: {
      s3_protocol: :https,
      bucket: ENV['AWS_BUCKET'],
      access_key_id: ENV['AWS_ACCESS_KEY'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  }

  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = false

  # See everything in the log (default is :info)
  config.log_level = :info

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  config.assets.version = '1.0'

  config.action_mailer.default_url_options = { host: ENV['MAIL_HOST']}
  ActionMailer::Base.smtp_settings = {
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => ENV['MAIL_DOMAIN'],
  :authentication => :plain,
  }
  config.action_mailer.delivery_method = :smtp
  # config.action_mailer.delivery_method = :mailgun
  # config.action_mailer.mailgun_settings = {
  #   domain: 'mg.fitly.org',
  #   api_key: ENV['MAILGUN_API_KEY']
  # }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new
end
