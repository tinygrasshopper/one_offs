require 'one_offs/tracker'

module OneOffs
  class Configuration

    class << self

      def check_for_pending
        Dir.glob(File.join(Dir.pwd, "lib", "one_offs", "*.rb")).sort.each do |one_off|
          check(one_off)
        end
      end

      private
      def check(one_off)
        one_off_name = File.basename(one_off, ".rb")

        if(!Tracker.complete?(one_off_name))
          puts "Pending one-off need to be run: #{one_off_name}. Run using `rake one_offs:run` "
        end
      end
    end
  end
end
