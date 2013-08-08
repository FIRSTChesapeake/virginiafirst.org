namespace :check do
  desc "Make sure local git is in sync with remote."
  task :revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "check:revision"
  before "deploy:migrations", "check:revision"
  before "deploy:cold", "check:revision"

  task :deployed, roles: :web do
    run "cat #{current_path}/REVISION"
    run "cd #{current_path} && git log --pretty=format:'%h @ %ad by %aN %d' `cat #{current_path}/REVISION` -1"
  end
end
