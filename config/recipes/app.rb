set_default(:google_client_id) { Capistrano::CLI.ui.ask "Google Client ID: " }
set_default(:google_client_secret) { Capistrano::CLI.password_prompt "Google Client Secret: " }

namespace :app do
  desc "Install dependencies required for this application"
  task :install, roles: :app do
    run "#{sudo} apt-get update"
    run "#{sudo} apt-get install imagemagick libmagick++-dev --yes"
  end

  desc "Generate the application.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "application.yml.erb", "#{shared_path}/config/application.yml"
  end
  after "deploy:setup", "app:setup"

  desc "Symlink the application.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "app:symlink"
end
