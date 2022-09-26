require 'one_offs/tracker'

module OneOffs
  class Runner
    class << self
      def run
        Dir.glob(File.join(Dir.pwd, "lib", "one_offs", "*.rb")).sort.each do |one_off|
          execute(one_off)
        end
      end

      private
      def execute(one_off)
        one_off_name = File.basename(one_off, ".rb")

        if(!Tracker.complete?(one_off_name))
          puts "Running #{one_off}"
          require one_off
          one_off_class = one_off_name.scan(/\d_(.*)/).flatten.first.camelize
          Object.const_get(one_off_class).send(:process)

          Tracker.complete(one_off_name)
        end
      end
    end
  end
end
