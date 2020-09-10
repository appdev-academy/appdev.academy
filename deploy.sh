#!/bin/bash

USER=root
HOST=appdev.academy
SSH_PORT=1235
APP_DIRECTORY=/www/appdev.academy

# Stop Nginx
ssh -p $SSH_PORT $USER@$HOST << ONE
  # Stop nginx server
  echo "/opt/nginx/sbin/nginx -s quit"
  /opt/nginx/sbin/nginx -s quit
  
  # Stop DelayedJob worker
  cd $APP_DIRECTORY
  RAILS_ENV=production bundle exec bin/delayed_job --pid-dir=$APP_DIRECTORY/tmp/pids stop
ONE

# Upload source code to server
# - avz                     - archive mode, increase verbosity, compress file data during the transfer
# --delete                  - delete extraneous files from destination dirs
# --filter=':- .gitignore'  - excluding files which are indicated in'.gitignore'
# -e "ssh -p 1235"          - user specified port
rsync -avz --filter=':- .gitignore' --exclude='.git' --exclude='deploy.sh' --exclude='deploy-precompile.sh' --delete  -e "ssh -p $SSH_PORT" ./ $USER@$HOST:$APP_DIRECTORY

ssh -p $SSH_PORT $USER@$HOST << TWO
  # Go to Rails app directory
  cd $APP_DIRECTORY
  
  # Update bundle
  RAILS_ENV=production bundle install --without development test
  
  # Install yarn packages
  RAILS_ENV=production yarn
  
  # Run migrations and seed database
  RAILS_ENV=production bundle exec rake db:migrate
  RAILS_ENV=production bundle exec rake db:seed
  
  chmod -R 777 ./tmp
  
  # Start Nginx server
  sudo /opt/nginx/sbin/nginx
  
  # Start DelayedJob workers
  mkdir -p $APP_DIRECTORY/tmp/pids
  RAILS_ENV=production bundle exec bin/delayed_job --pid-dir=$APP_DIRECTORY/tmp/pids -n 2 start
  RAILS_ENV=production bundle exec rake recurring_delayed_jobs:reschedule
TWO
