module Menumatic
  module Navigation
    class Base
      include ActionView::Helpers
      @@navigations = {}
      attr_accessor :id, :root

      class << self
        def navigate_to(label, destination, options = {})
          if block_given?
            item = self.get_instance.root.navigate_to(label, destination, options, &Proc.new)
          else
            item = self.get_instance.root.navigate_to(label, destination, options)
          end
        end

        def group(id)
          if block_given?
            group = self.get_instance.root.group(id, &Proc.new)
          else
            group = self.get_instance.root.group(id)
          end
        end

        def get_instance
          id = self.name.split("Navigation").first.underscore.to_sym 
          @@navigations[id] = self.new(id) unless @@navigations.has_key?(id)
          @@navigations[id]
        end

        def get(id)
          unless @@navigations.has_key?(id)
            Module.const_get("#{id.to_s.camelize}Navigation").get_instance
          end
          @@navigations[id]
        end

        def destroy_all
          @@navigations = {}
        end

        def load_navigation(navigation_id)
          # Eager load the requested navgation (allows for use of normal if/unless statements)
          Menumatic::Navigation::Base.destroy_all
          load "app/navigation/#{navigation_id}_navigation.rb"
          Menumatic::Navigation::Base.get(navigation_id)
        end
      end

      def initialize(id)
        self.id = id
        self.root = Menumatic::Navigation::Item::Group.new("#{id}_root".to_sym)
      end

      def items
        self.root.items
      end

    end
  end
end

