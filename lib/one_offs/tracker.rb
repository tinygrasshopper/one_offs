module OneOffs
  class Tracker < ActiveRecord::Base
    set_table_name "OneOffTracker"

    class << self
      def complete?(name)
        find_by_name(name).present?
      end

      def complete(name)
        create(:name => name)
      end
    end
  end
end

