source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

#Bootstrap for styling
gem 'bootstrap-sass', '~> 3.2.0'

#Facebook Authentication
gem 'omniauth'
gem 'omniauth-facebook', '1.4.0'

gem 'rails_12factor', group: :production

gem 'newrelic_rpm'


#Mongo Gear
#Actual mongo drive
gem "mongo"
#mongo wrapper to make mongo act like ActiveRecord
gem "mongo_mapper"
#speeds up bson operations by replacing bson with a driver written in C
gem "bson_ext"

#Add browser vendor prefixes automatically
gem 'autoprefixer-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

