require "bundler/capistrano"

load "deploy/assets"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/app"
load "config/recipes/check"

server "198.199.87.210", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "vafirst"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
#set :shared_children, shared_children + %w{public/uploads}

set :scm, "git"
set :repository, "ssh://git@bitbucket.org/cattywampus/vafirst.git"
set :branch, "master"

set :host_name, "virginiafirst.cattywamp.us"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"
