server 'localhost', user: 'xavier', roles: %w{web app}

set :deploy_to, "/home/xavier/tmp/cap/#{fetch(:application)}"