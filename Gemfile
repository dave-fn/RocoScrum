source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Authentication - JWT
gem 'knock', '~> 2.1'

# JSON API spec
gem 'jsonapi-resources', '~> 0.9.0'

# JSON API Authorization
gem 'jsonapi-authorization', '~> 1.0'

# Hashids
gem 'hashid-rails', '~> 1.2'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Better Errors
  gem 'better_errors', '~> 2.5'

  # RuboCop
  gem 'rubocop', '~> 0.64.0', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # RSpec
  gem 'rspec-rails', '~> 3.8'

  # Factory Bot
  gem 'factory_bot_rails', '~> 4.11'

  # Awesome Print
  gem 'awesome_print', '~> 1.8'
end

group :test do
  # Shoulda Matchers
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing' # Required due to using Rails 5.x

  # Database Cleaner
  gem 'database_cleaner', '~> 1.7'

  # Faker
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'

  # Pundit Matchers
  gem 'pundit-matchers', '~> 1.6.0'

  # SimpleCov
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
