#!/bin/bash


HOST=appdev.academy
SSH_PORT=1235
APP_DIRECTORY=/www/appdev.academy-rails


ssh -p $SSH_PORT root@$HOST << SCRIPT
  # Stop nginx server
  service nginx stop
  
  # Go to Rails app directory
  cd $APP_DIRECTORY
  
  # Pull new changes
  git fetch origin
  git reset --hard origin/master
  
  # Update bundle
  RAILS_ENV=production bundle install
  
  # Install yarn packages
  RAILS_ENV=production yarn
  
  # Run migrations and seed database
  RAILS_ENV=production bundle exec rake db:migrate
  RAILS_ENV=production bundle exec rake db:seed
  
  # Clear Rails app (logs, temp files, precompiled assets)
  RAILS_ENV=production bundle exec rake log:clear
  RAILS_ENV=production bundle exec rake tmp:clear
  rm -rf public/assets
  
  # Precompile assets
  RAILS_ENV=production bundle exec rake assets:precompile
  
  # Start Nginx server
  service nginx start
  
  # Restart Delayed::Job
  mkdir -p $APP_DIRECTORY/tmp/pids
  RAILS_ENV=production bundle exec bin/delayed_job --pid-dir=$APP_DIRECTORY/tmp/pids -n 2 restart
  RAILS_ENV=production bundle exec rake recurring_delayed_jobs:reschedule
SCRIPT
