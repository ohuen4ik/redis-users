source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'
gem 'bcrypt', '~> 3.1', '>= 3.1.18'
gem 'bootsnap', require: false
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.4'
gem 'redis'
gem 'rswag'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'strong_password', '~> 0.0.9'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'mock_redis'
  gem 'pry', require: false
  gem 'pry-byebug', require: false
  gem 'pry-rails'
  gem 'rspec-retry'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
end

group :development do
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'spring'
  gem 'spring-commands-rspec'
end
