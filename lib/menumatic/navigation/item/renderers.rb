module Menumatic
  module Navigation
    module Item
      module Renderers
        include ActionView::Helpers::UrlHelper
        @@level_options = [:primary, :secondary, :tertiary, :quarternary, :quinary, :senary, :septenary, :octonary, :nonary, :denary]

        def render(request, options = {})
          options[:current_level] ||= 0

          html_options = {}
          options = options.merge({})
          options[:current_level] += 1

          options[:wrapper_tag] ||= :ul
          options[:item_tag] ||= :li

          # render list
          list = self.items.map{ |item| item.render(request, options) }.join("")
          html_options[:class] ||= ""
          html_options[:class] += self.is_active?(request) ? "active" : "inactive"

          unless list.blank?
            list_options = html_options.merge({})
            list_options[:class] += " level_#{options[:current_level]}"
            if on_valid_level?(options[:levels], options[:current_level]) || options[:current_level] == 1
              list = content_tag(options[:wrapper_tag], list.html_safe, list_options)
            else
              list = list.html_safe
            end
          end

          # render link
          link = ""
          if self.is_group? && options[:group] && options[:group] == self.id
            link = content_tag(options[:item_tag], self.id.to_s, html_options)
          elsif self.is_link?
            link = content_tag(options[:item_tag], link_to(self.label, self.destination), html_options)
          end

          if on_valid_level?(options[:levels], options[:current_level])
            if self.is_active?(request) || options[:current_level] == 1
              (link + list).html_safe
            else
              link.html_safe
            end
          elsif self.is_active?(request)
            list.html_safe
          end
        end

        def is_active?(request)
          has_active_descendant?(request) || paths_match?(request)
        end

        def has_active_descendant?(request)
          self.items.each do |item|
            return true if item.has_active_descendant?(request)
          end
          return true if paths_match?(request)
        end

        def paths_match?(request)
          request.fullpath == self.destination || request.url == self.destination if self.is_link?
        end

        def on_valid_level?(levels, current_level)
          levels_to_i(levels).include?(current_level-1) || levels.empty?
        end

        def levels_to_i(levels_in_words)
          levels_in_words.map{ |word| @@level_options.index(word.to_sym) + 1 }
        end
      end
    end
  end
end
