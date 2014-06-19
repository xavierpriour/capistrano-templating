server 'localhost', user: 'xavier', roles: %w{web app}

set :deploy_to, "~/tmp/cap/#{fetch(:application)}"