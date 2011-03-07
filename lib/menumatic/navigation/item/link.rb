module Menumatic
  module Navigation
    module Item
      class Link < Menumatic::Navigation::Item::Base
        attr_accessor :label, :destination
        def initialize(*args)
          super
          self.label = args[0]
          self.destination = args[1]
        end
      end
    end
  end
end
