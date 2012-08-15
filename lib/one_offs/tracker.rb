require 'active_record'

module OneOffs
  class Tracker < ActiveRecord::Base
    self.table_name = "one_off_tracker"
    attr_accessible :name

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

