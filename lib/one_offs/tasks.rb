require 'one_offs/runner'
namespace :one_offs do
  desc "Run all the one-off scripts"
  task :run  => :environment do
    OneOffs::Runner.run
  end


  desc "Create a one off tracker table"
  task :generate_tracker_table do
    `script/generate migration CreateOneOffTracker name:string`
  end
end
