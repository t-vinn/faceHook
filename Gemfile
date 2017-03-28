# frozen_string_literal: true
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'brakeman'
  gem 'byebug', platform: :mri
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rubycritic'
  gem 'slim_lint'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'pry-rails'

  # debugger
  gem 'pry-byebug'
  gem 'pry-stack_explorer'

  # pry input/output colored
  gem 'awesome_print'
  gem 'pry-coolline'

  # pry output formatted
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'web-console', '>= 3.3.0'

  # find n+1 problem
  gem 'bullet'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'spring-commands-rspec'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Devise
gem 'devise'

# slim
gem 'slim-rails'

# bootstrap
gem 'bootstrap-sass'

# compass
gem 'compass-rails'

# font-awesome
gem 'font-awesome-rails'

# upload pictures: carrierwave
gem 'carrierwave'

# resize pictures
gem 'mini_magick'

# for file uploads & paginations
gem 'jquery-turbolinks'
gem 'kaminari'

# for nested_form
gem 'nested_form'

# for bootstrap_form
gem 'bootstrap_form'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap-fileinput', '~> 2.5.0'
end

# activeadmin, Rails5
gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'

# mailer: Asynchronous processing
gem 'daemons'

# redis
gem 'redis'

# mailer delayed_job
gem 'delayed_job_active_record'

# slack integration
gem 'httparty'

# run rake task once a day
gem 'whenever', require: false

# passwords
gem 'config'

gem 'activesupport'
