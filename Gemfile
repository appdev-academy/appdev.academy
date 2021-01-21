source 'https://rubygems.org'

ruby '2.7.1'

# Rails
gem 'rails', '~> 6.1.1'

# Use postgresql as the database for Active Record
gem 'pg'

# Use Puma as the app server
gem 'puma'

gem 'react_on_rails', '11.1.3' # Update to the current version
gem 'webpacker', '~> 3' # Newer versions might be supported

gem 'bootstrap', '4.1.3'
gem 'bootstrap-datepicker-rails'
gem 'font-awesome-sass', '4.7.0'

# Set environment variables safely
gem 'figaro'

# Use jQuery as main JavaScript library
gem 'jquery-rails'

# Compress JavaScript files with uglifier
gem 'uglifier'

# Use SCSS for generating CSS
gem 'sass-rails'

# Use Slim as template language for HTML
gem 'slim-rails'

# Allow cross-origin requests
gem 'rack-cors'

# Social media sharing
gem 'social-share-button'

# Google Analytics
gem 'rack-google-analytics'

# JSON serializers for ActiveRecord objects
gem 'active_model_serializers'

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Add meta tags to pages
gem 'meta-tags'

# File uploading
gem 'carrierwave'
# Image processor for uploaded images with Carrierwave
gem 'mini_magick'
# AWS S3 adapter for Carrierwave
gem 'fog-aws'

# Background jobs
gem 'delayed_job_active_record'
gem 'delayed_job_recurring'
gem 'daemons'

group :development do
  gem 'listen'
  
  # Mailer
  gem 'letter_opener'
end

group :development, :test do
  # Use Rspec to test Rails app
  gem 'rspec-rails'
end

group :test do
  # Fixture replacement
  gem 'factory_bot_rails'
  # Fake data generator
  gem 'faker'
  # RSpec one-line tests
  gem 'shoulda-matchers'
  # Express expected outcomes for RSpec tests
  gem 'rspec-expectations'
end
