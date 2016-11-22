source 'https://rubygems.org'

# Rails
gem 'rails', '5.0.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'

# Allow cross-origin requests
gem 'rack-cors'

# Serializers for ActiveRecord objects
gem 'active_model_serializers', '0.10.2'

# Use ActiveModel has_secure_password
gem 'bcrypt'

# File uploading
gem 'carrierwave'
# Image processor for uploaded images with Carrierwave
gem 'mini_magick'

group :development do
  gem 'listen'
end

group :development, :test do
  # Use Rspec to test Rails app
  gem 'rspec-rails'
end

group :test do
  # Fixture replacement
  gem 'factory_girl_rails'
  # Fake data generator
  gem 'faker'
  # RSpec one-line tests
  gem 'shoulda-matchers'
  # Express expected outcomes for RSpec tests
  gem 'rspec-expectations'
end

group :production do
  # Use Therubyracer as JavaScript runtime in production
  gem 'therubyracer'
end