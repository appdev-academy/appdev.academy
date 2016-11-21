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
  
  # Run database migrations
  RAILS_ENV=production rake db:migrate
  
  # Start Nginx server
  service nginx start
SCRIPT