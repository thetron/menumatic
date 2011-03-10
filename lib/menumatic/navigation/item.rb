module Menumatic
  module Navigation
    module Item
      class Base
        attr_accessor :items, :html_options, :wrapper_options

        include Menumatic::Navigation::Item::Renderers
        include Menumatic::Navigation::Item::Navigators

        def initialize(*args)
          self.html_options = {}
          self.wrapper_options = {}
          if(args.last.is_a?(Hash))
            self.html_options = args.last[:link_html] || {}
            self.wrapper_options = args.last[:wrapper_html] || {}
          end
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
