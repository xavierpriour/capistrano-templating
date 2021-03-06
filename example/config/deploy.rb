set_template 'www/deploy.html', 'deploy.html.erb'
set_template 'www/php/config.php', 'config.php.erb'



set :application, 'capistrano_example_app'

set :scm, :git
set :repo_url, 'https://github.com/xavierpriour/capistrano-template.git'


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
