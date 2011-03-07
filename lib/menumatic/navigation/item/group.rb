module Menumatic
  module Navigation
    module Item
      class Group < Menumatic::Navigation::Item::Base
        attr_accessor :id
        def initialize(*args)
          super
          self.id = args[0]
        end
      end
    end
  end
end
