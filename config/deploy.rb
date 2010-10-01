set :application, "meteor_catalog"
set :repository, "git@github.com:auranet/meteor_catalog.git"
ssh_options[:forward_agent] = true
set :git_enable_submodules, 1

set :scm, :git
set :use_sudo, false
set :deploy_to, "/var/www/virtual/#{application}"

role :web, "www.aura-software.com"
role :app, "www.aura-software.com"
role :db,  "www.aura-software.com", :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
