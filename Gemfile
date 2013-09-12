source 'https://rubygems.org'

# Basic service gems
gem 'grape'                         # API Framework
gem 'json'                          # JSON
gem 'activerecord', '~> 4.0.0'      # Database
gem 'roar'                          # Representer
gem 'foreman'                       # Process management
gem 'rake'
gem 'sqlite3'
gem 'thin'

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
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'awesome_print'
end
