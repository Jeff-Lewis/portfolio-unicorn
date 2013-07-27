source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

# Use unicorn as the app server
gem 'unicorn'

gem 'faraday'
gem 'faraday_middleware'

#authentication + admin pannel
gem 'devise'
gem 'cancan', '= 1.6.9' #use exact version as 1.6.10 has a bug making it not work properly with shallow route path

gem 'activeadmin', github: 'gregbell/active_admin'
gem 'ransack', github: 'ernie/ransack', branch: 'rails-4'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'formtastic', github: 'justinfrench/formtastic'

# represent money
gem 'money-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'clockwork'
gem 'delayed_job_active_record', '~> 4.0.0'

#add foreign keys to relationships
gem 'foreigner'

# Build JSON APIs
gem 'rabl'
gem 'oj'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development do
    #pretty print in console
    gem 'hirb'
    gem 'wirble'
    gem 'awesome_print'
    #annotate files with db schema
    gem 'annotate'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'rack-test'
  gem 'rspec-http'
  gem 'json_spec'
end
