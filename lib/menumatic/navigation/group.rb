module Menumatic
  module Navigation
    module Group
      class Base
        attr_accessor :id, :items, :groups
        include Menumatic::Navigation::Item::Navigators

        def initialize(id)
          self.id = id
          self.items = []
          self.groups = {}
        end
      end
    end
  end
end
