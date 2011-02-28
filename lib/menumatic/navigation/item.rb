module Menumatic
  module Navigation
    module Item
      class Base
        attr_accessor :is_root, :items, :groups, :label, :destination, :options, :html_options

        include Menumatic::Navigation::Item::Renderers
        include Menumatic::Navigation::Item::Navigators

        def initialize(label, destination, options = {}, html_options = {})
          self.label = label
          self.destination = destination
          self.options = options
          self.html_options = html_options
          self.is_root = options[:root]
          self.items = []
          self.groups = {}
        end

      end
    end
  end
end
