#!/bin/bash
echo "Installing dependencies..."
bundle install
echo "Setting up database..."
bundle exec rake db:setup
echo "Migrating database..."
bundle exec rake db:migrate
echo "Starting server..."
rails s