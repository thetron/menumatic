module Menumatic
  module Navigation
    class Item
      attr_accessor :is_root, :items, :label, :destination, :options, :html_options

      include ActionView::Helpers::UrlHelper
      def initialize(label, destination, options = {}, html_options = {})
        self.label = label
        self.destination = destination
        self.options = options
        self.html_options = html_options
        self.is_root = options[:root]
        self.items = []
      end

      def render(options = {})
        options[:active] ||= false

        html_options = self.html_options
        html_options[:class] = "active" if options[:active] || self.is_active?

        if self.is_root
          self.label
        else
          link_to(self.label, self.destination, html_options).html_safe
        end
      end

      def navigate_to(label, destination, options = {}, html_options = {})
        item = add_item(Menumatic::Navigation::Item.new(label, destination, options, html_options))
        yield item if block_given?
      end

      def is_active?
        false
      end

      private
      def add_item(item)
        self.items << item
        item
      end
    end
  end
end
