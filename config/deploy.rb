# Whenever
set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { rails_env }
#### SERVER_IPとSSH_PORTをセット ####
set :whenever_roles, defer { "SERVER_IP:SSH_PORT" }
require "whenever/capistrano"
after 'deploy:update', 'whenever:update_crontab'