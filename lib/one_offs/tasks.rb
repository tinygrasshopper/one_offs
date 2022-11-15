require 'one_offs/runner'
require 'one_offs/configuration'

namespace :one_offs do
  desc "Run all the one-off scripts"
  task :run  => :environment do
    OneOffs::Runner.run
  end

  desc "Create a one off script"
  task :create_one_off do
    # Get command line arguments
    ARGV.each { |a| task a.to_sym do ; end }

    directory = Rails.root.join('lib', 'one_offs')
    filename = ARGV[1]
    time = Time.now.to_i

    File.open("#{directory}/#{time}_#{filename}.rb", "w") do |file|
      contents = "class #{filename.camelize}\n"\
                 "  def self.process\n"\
                 "    # Enter your migration code here....\n"\
                 "  end\n"\
                 "end"

      file.puts(contents)
    end

    spec_directory = Rails.root.join('spec', 'lib', 'one_offs')

    File.open("#{spec_directory}/#{time}_#{filename}_spec.rb", "w") do |file|
      contents = <<~CONTENT
        require 'rails_helper'
        require 'one_offs/#{time}_#{filename}'

        RSpec.describe #{filename.camelize} do
          before { described_class.process }

          it 'CHANGEME' do
            expect(1).to eq(2)
          end
        end

      CONTENT
      file.puts(contents)
    end

    puts "Created \e[32m lib/one_offs/#{time}_#{filename}.rb \e[0m"
    puts "Created \e[32m spec/lib/one_offs/#{time}_#{filename}_spec.rb \e[0m"
  end

  desc "Create a one off tracker table"
  task :generate_tracker_table do
    `rails generate migration CreateOneOffTracker name:string`
  end

  desc "Turn on pending one_offs notification in development environment"
  task :turn_on_pending_notification do
    filepath = Rails.root.join('config', 'initializers', 'one_offs.rb')

    File.open(filepath, "w") do |file|
      contents = "require 'one_offs/configuration'\n"\
                  "\n"\
                  "if Rails.env.development?\n"\
                  "  OneOffs::Configuration.check_for_pending\n"\
                  "end\n"\

      file.puts(contents)
    end
  end

  desc 'Create one off tracker table using SQL instead of migration'
  task :create_tracker_table_using_sql => :environment do
    sql = 'CREATE TABLE IF NOT EXISTS "one_off_trackers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar);'
    ActiveRecord::Base.connection.execute(sql)
  end
end
