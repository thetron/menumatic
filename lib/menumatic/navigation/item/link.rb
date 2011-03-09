module Menumatic
  module Navigation
    module Item
      class Link < Menumatic::Navigation::Item::Base
        attr_accessor :label, :destination, :active_paths
        def initialize(*args)
          super
          self.label = args[0]
          self.destination = args[1]

          if args.length > 2
            options = args[2]
            self.active_paths = options[:active_on]
          end
          self.active_paths ||= []
        end
      end
    end
  end
end
