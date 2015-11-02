source 'https://rubygems.org'

# ruby '2.2.0'

# Basic service gems
gem 'json'                          # JSON
gem 'roar'                          # Representer
gem 'foreman'                       # Process management
gem 'rake'
gem 'racksh'
gem 'thin'
gem 'rack-cors', :require => 'rack/cors'
gem 'sprockets'
gem 'sinatra'

# DB
gem 'activerecord', '~> 4.0.0'      # Database

# Auth
gem 'warden'
gem 'devise'

# API Framework
gem 'grape'
gem 'grape-swagger'

group :development do
  gem 'rerun'
  gem 'mina' # Deployment
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'bogus'
  gem 'database_cleaner'
  gem 'timecop'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'awesome_print'
end

group :production do
  gem 'pg'
end
