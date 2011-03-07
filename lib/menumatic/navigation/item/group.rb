module Menumatic
  module Navigation
    module Item
      class Group < Menumatic::Navigation::Item::Base
        attr_accessor :group_id
        def initialize(*args)
          super
          self.group_id = args[0]
        end
      end
    end
  end
end
