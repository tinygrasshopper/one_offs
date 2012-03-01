namespace :one_offs do
  desc "run all the one-off scripts"
  task :run  => :environment do
    Dir.glob(File.join(RAILS_ROOT, "db", "one_offs", "*.rb")).sort.each do |one_off|
      puts "Running #{one_off}"
      require one_off
      one_off_name = File.basename(one_off, ".rb")
      one_off_class = one_off_name.scan(/\d_(.*)/).to_s.classify
      Object.const_get(one_off_class).send(:process)
    end
  end
end
