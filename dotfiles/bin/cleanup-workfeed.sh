#!/bin/bash

bundle exec rake db:drop db:create db:structure:load db:migrate db:test:prepare repairs:update_client_applications db:populate_experiments tr8n:init dev:clear_cache -t

