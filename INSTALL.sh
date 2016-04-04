#!/bin/bash
bundle install
rake db:setup
rake db:migrate
rails s