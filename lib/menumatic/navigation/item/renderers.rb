module Menumatic
  module Navigation
    module Item
      module Renderers
        include ActionView::Helpers::UrlHelper
        @@level_options = [:primary, :secondary, :tertiary, :quarternary, :quinary, :senary, :septenary, :octonary, :nonary, :denary]

        def render(request, options = {})
          options[:current_level] ||= 0

          html_options = {}
          html_options[:class] = options[:class]
          options.delete(:class)
          options = options.merge({})
          options[:current_level] += 1

          options[:show] ||= :active
          options[:wrapper_tag] ||= :ul
          options[:item_tag] ||= :li

          # render list
          list = self.items.map { |item| item.render(request, options) }.join("")
          html_options[:class] ||= ""
          html_options[:class] = (html_options[:class].split(" ") + (self.is_active?(request) ? ["active"] : ["inactive"])).join(" ")

          unless list.blank?
            list_options = html_options.merge({})
            list_options[:class] += " level_#{options[:current_level]}"
            list_options[:class] += " depth_#{count_active_descendants(request)}" if options[:current_level] == 1
            if on_valid_level?(options[:levels], options[:current_level]) || options[:current_level] == 1
              list = content_tag(options[:wrapper_tag], list.html_safe, list_options)
            else
              list = list.html_safe
            end
          end


          # render link
          link = ""
          link = link_to(self.label, self.destination).html_safe if self.is_link? && !options[:group]

          if on_valid_level?(options[:levels], options[:current_level])
            if options[:current_level] == 1 || (self.is_group? && options[:group] == self.group_id)
              list.html_safe
            elsif options[:show] == :all || self.is_active?(request)
              content_tag(options[:item_tag], link.to_s + list.to_s, html_options).to_s.html_safe
            else
              content_tag(options[:item_tag], link, html_options).to_s.html_safe
            end
          elsif self.is_active?(request)
            list.html_safe
          end
        end

        def render_sitemap(document, options = {})
          if is_link?
            document.url do
              document.loc self.destination
              document.changefreq "weekly"
            end
          end
          self.items.each{ |item| item.render_sitemap(document, options) }
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

        def count_active_descendants(request)
          self.items.each do |item|
            return item.count_active_descendants(request) + 1 if item.has_active_descendant?(request)
          end
          if self.is_group? && !self.has_active_descendant?(request)
            return 1
          end
          0
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
