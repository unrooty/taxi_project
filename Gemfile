source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'pg', '~> 0.21'
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
gem 'dry-matcher'
gem 'dry-monads'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'actionpack-action_caching'
gem 'actionpack-page_caching'
gem 'bootstrap', '~> 4.0.0.beta'
gem 'pundit'
gem 'carrierwave', '~> 1.0'
gem 'daemons'
gem 'delayed_job_active_record'
gem 'devise'
gem 'font-awesome-rails'
gem 'font-awesome-sass'
gem 'haml'
gem 'haml-rails'
gem 'rails-i18n'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rack-cache'
gem 'redis-rails'
gem 'redis-store'
gem 'rubocop', require: false
# gem 'simplecov', :require => false, :group => :test
gem 'trailblazer-cells'
gem 'trailblazer-rails'
gem 'trailblazer-endpoint', git: 'https://github.com/trailblazer/trailblazer-endpoint.git'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'factory_bot'
  gem 'rspec-rails', '~> 3.6'
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
end

group :development do
  gem 'letter_opener'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
