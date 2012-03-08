namespace :one_offs do
  desc "Run all the one-off scripts"
  task :run  => :environment do
    Runner.run
  end
end
