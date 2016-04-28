require 'one_offs/runner'
namespace :one_offs do
  desc "Run all the one-off scripts"
  task :run  => :environment do
    OneOffs::Runner.run
  end


  desc "Create a one off tracker table"
  task :generate_tracker_table do
    `rails generate migration CreateOneOffTracker name:string`
  end

  desc 'Create one off tracker table using SQL instead of migration'
  task :create_tracker_table_using_sql => :environment do
    sql = 'CREATE TABLE IF NOT EXISTS "one_off_trackers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar);'
    ActiveRecord::Base.connection.execute(sql)
  end
end
