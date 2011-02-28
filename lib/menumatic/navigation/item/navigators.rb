module Menumatic
  module Navigation
    module Item
      module Navigators
        def navigate_to(label, destination, options = {}, html_options = {})
          item = add_item(Menumatic::Navigation::Item::Base.new(label, destination, options, html_options))
          yield item if block_given?
        end

        def group(id)
          self.groups[id] = Menumatic::Navigation::Group::Base.new(id) unless self.groups.has_key?(id)
          group = self.groups[id]
          yield group if block_given?
        end

        private
        def add_item(item, group = nil)
          self.items << item
          item
        end
      end
    end
  end
end
