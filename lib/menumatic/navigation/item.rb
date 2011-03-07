module Menumatic
  module Navigation
    module Item
      class Base
        attr_accessor :items, :options

        include Menumatic::Navigation::Item::Renderers
        include Menumatic::Navigation::Item::Navigators

        def initialize(*args)
          self.options = args.last
          self.items = []
        end

        def is_link?
          self.is_a? Menumatic::Navigation::Item::Link
        end

        def is_group?
          self.is_a? Menumatic::Navigation::Item::Group
        end

        private
        def add_item(item)
          self.items << item
          item
        end
      end
    end
  end
end
