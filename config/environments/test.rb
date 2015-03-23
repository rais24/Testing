module Authentication
  # Force a User to be authenticated
  # ala http://robots.thoughtbot.com/post/37907699673/faster-tests-sign-in-through-the-back-door
  class BackDoor
    def initialize(app)
      @app = app
    end

    def call(env)
      @env = env
      sign_in_through_the_back_door
      @app.call(@env)
    end

    private

      def sign_in_through_the_back_door
        if user_id = params['as']
          authenticator = Authenticator.new(@env['rack.session'])
          authenticator.login(User.find(user_id))
        end
      end

      def params
        Rack::Utils.parse_query(@env['QUERY_STRING'])
      end
  end
end

Fitly::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  config.middleware.use Authentication::BackDoor

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"
  
  config.action_mailer.default_url_options = {
    host: "www.example.com",
    port: 3000
  }

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
end
