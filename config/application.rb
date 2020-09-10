require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppDev
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('app', 'jobs', 'estimate_requests')
    config.autoload_paths << Rails.root.join('app', 'jobs', 'recurring')
    
    # Use Google Analytics
    config.middleware.use Rack::GoogleAnalytics, tracker: ENV['GOOGLE_ANALYTICS_TRACKING_ID']
    
    # Queue adapter for ActiveJobs
    config.active_job.queue_adapter = :delayed_job
    
    # Disable automatic generation for TestUnit, JS, CSS files and helpers
    config.generators do |g|
      g.test_framework :rspec, views: false, fixture: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.stylesheets false
      g.javascripts false
      g.helper false
    end
  end
end
