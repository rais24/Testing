source 'http://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 4.0.5'

gem 'browser'

gem 'unicorn'

gem "gibbon", "~> 1.1.1"

# for images
gem 'paperclip'
gem 'aws-sdk', '~> 1.5.7'
gem 'cocaine'

# for measurement units
gem 'ruby-units'
gem 'fraction'

# for dates
gem 'chronic'

# user authentication/authorization
gem 'cancan'

# for charts
gem 'chartkick', '~> 1.3.2'

# facebook
gem 'omniauth'
gem 'omniauth-facebook'

# parsing recipes from websites
gem 'hangry'

# parsing portions from recipes
gem 'ingreedy'

# for registration wizard
gem 'wicked'

gem 'lograge'

gem 'simple_form', github: 'plataformatec/simple_form'

gem 'sidekiq'
# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', '>= 1.3.0', require: nil

gem 'roadie', '2.4.1'

gem 'mysql2'

gem 'high_voltage'
gem 'rack-www'

gem 'stripe'
gem 'money-rails'
gem 'monetize'

gem 'whenever', require: false

gem 'going_postal'
gem 'mail_view', '~> 1.0.3'
gem 'mailgunner', '~> 1.3.0'

gem 'rubber', '~> 2.5.2'

# for the shopping cart
gem 'acts_as_shopping_cart', '~> 0.2.0', github: "fitly/acts_as_shopping_cart"

gem 'highline', '~> 1.7.1'

gem 'prawn'
#gem 'prawn', :git => "https://github.com/prawnpdf/prawn.git", :ref => '8028ca0cd2'

# handle incoming email
#gem 'griddler', github: 'thoughtbot/griddler'

# for monitoring
gem 'newrelic_rpm'

# granular environment configuration
gem 'custom_configuration'

# To replicate and transfer databases
gem 'replicate'

# for boiler plate cleanup
gem 'inherited_resources', github: 'josevalim/inherited_resources'

gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'sass-rails'
gem 'coffee-rails'
gem 'sprockets', '2.11.0' # lock sprockets

gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'font-awesome-rails'

gem 'jquery-waypoints-rails'

gem 'therubyracer', platform: :ruby

gem 'uglifier', '>= 1.0.3'

# for tagging recipes
gem 'acts-as-taggable-on'

gem 'haml-rails'
gem 'slim-rails'
gem 'jquery-rails'
gem 'bourbon'
gem 'neat'
gem 'pg'


#gem 'simple_form', '~> 3.0.0.rc'
gem 'client_side_validations', github: "bcardarella/client_side_validations", :branch => "4-0-beta"
gem 'client_side_validations-simple_form', git: 'git://github.com/saveritemedical/client_side_validations-simple_form.git'

group :production do
  gem "rails_12factor"
end

group :development do
  gem 'foreman'
  gem 'coffee-rails-source-maps'
  # gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-bundler'
  gem 'letter_opener'
  gem 'rack-livereload'
  gem 'guard-livereload'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'email_spec'
  gem 'database_cleaner'
  gem 'webmock'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.12'
  gem 'shoulda-matchers'
  gem 'zeus'
  gem 'guard-rspec'
  gem 'dotenv-rails'
  gem 'better_errors'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

gem 'open4'

gem 'gelf'
gem 'graylog2_exceptions', github: 'wr0ngway/graylog2_exceptions'
gem 'graylog2-resque'

# Annotate for easy schema viewing in the models
gem 'annotate', ">=2.6.0"

# Encryption for HIPAA compliance
gem 'attr_encrypted'

# Messaging
gem 'mailboxer'
