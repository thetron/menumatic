module Menumatic
  module Navigation
    module Item
      module Navigators
        def navigate_to(label, destination, options = {})
          item = add_item(Menumatic::Navigation::Item::Link.new(label, destination, options))
          yield item if block_given?
        end

        def group(id, options = {})
          item = add_item(Menumatic::Navigation::Item::Group.new(id, options))
          yield item if block_given?
        end
      end
    end
  end
end
