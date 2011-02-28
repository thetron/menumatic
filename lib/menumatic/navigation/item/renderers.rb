module Menumatic
  module Navigation
    module Item
      module Renderers
        include ActionView::Helpers::UrlHelper

        def render(request, options = {})
          options[:active] ||= false
          html_options = self.html_options
          html_options[:class] = "active" if options[:active] || self.is_active?(request)

          if self.is_root
            self.label
          else
            link_to(self.label, self.destination, html_options).html_safe
          end
        end

        def is_active?(request)
          if self.options[:active_paths]
            self.options[:active_paths].include?(request.fullpath) || self.options[:active_paths].include?(request.url)
          else
            request.fullpath == self.destination || request.url == self.destination
          end
        end
      end
    end
  end
end
