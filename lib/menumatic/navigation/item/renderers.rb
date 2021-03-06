module Menumatic
  module Navigation
    module Item
      module Renderers
        include ActionView::Helpers::UrlHelper
        @@level_options = [:primary, :secondary, :tertiary, :quarternary, :quinary, :senary, :septenary, :octonary, :nonary, :denary]

        def render(request, options = {})
          options[:current_level] ||= 0

          html_options = {}
          html_options[:id] = options[:id] if options[:id]
          html_options[:class] = options[:class] if options[:class]
          options.delete(:id)
          options.delete(:class)
          options = options.merge({})
          options[:current_level] += 1

          options[:show] ||= :active
          options[:wrapper_tag] ||= :ul
          options[:item_tag] ||= :li

          # 1.0 roadmap - rendering should be divided into these two methods
          render_as_link(request, options) || render_as_group(request, options)

          # render list
          list = self.items.map { |item| item.render(request, options) }.join("")
          html_options[:class] ||= ""
          html_options[:class] = (html_options[:class].split(" ") + (self.is_active?(request) ? ["active"] : ["inactive"])).join(" ")

          unless list.blank?
            list_options = html_options.merge({})
            list_options[:class] += " level_#{options[:current_level]}"
            list_options[:class] += " depth_#{depth_count(request, options)}" if options[:current_level] == 1
            if on_valid_level?(options[:levels], options[:current_level]) || options[:current_level] == 1
              list = content_tag(options[:wrapper_tag], list.html_safe, list_options)
            else
              list = list.html_safe
            end
          end

          # render link
          link = ""
          link = link_to(self.label, self.destination, self.html_options).html_safe if self.is_link? && !options[:group]
          if on_valid_level?(options[:levels], options[:current_level])
            if (options[:current_level] == 1 && self.is_group?) || (self.is_group? && options[:group] == self.group_id)
              list.html_safe
            elsif options[:show] == :all || self.is_active?(request)
              content_tag(options[:item_tag], link.to_s + list.to_s, html_options.merge_with_join(self.wrapper_options)).to_s.html_safe
            elsif self.is_link?
              content_tag(options[:item_tag], link, html_options.merge_with_join(self.wrapper_options)).to_s.html_safe
            end
          elsif self.is_active?(request)
            list.html_safe
          end
        end

        def render_sitemap(document, request, options = {})
          if is_link?
            unless self.destination[0...10] == "javascript"
              document.url do
                if self.destination[0...4] == "http"
                  document.loc self.destination
                else
                  document.loc request.protocol + request.host_with_port + self.destination
                end
                document.changefreq "weekly"
              end
            end
          end
          self.items.each{ |item| item.render_sitemap(document, request, options) }
        end

        def is_active?(request)
          has_active_descendant?(request) || paths_match?(request)
        end

        def has_active_descendant?(request, include_self = true)
          self.items.each do |item|
            return true if item.has_active_descendant?(request)
          end
          return true if paths_match?(request) if include_self
          false
        end

        def count_active_descendants(request)
          self.items.each do |item|
            return item.count_active_descendants(request) + 1 if item.has_active_descendant?(request)
          end

          if (self.paths_match?(request) && !self.has_active_descendant?(request, false) && self.items.count > 0)
            return 1
          elsif (self.is_group? && !self.has_active_descendant?(request)) || (self.paths_match?(request) && !self.has_active_descendant?(request, false))
            return 0
          end
          0
        end

        def depth_count(request, options = {})
          return options[:levels].count if options[:levels] && !options[:levels].empty?
          depth = count_active_descendants(request)
          (depth > 0) ? depth : 1
        end

        def paths_match?(request)
          if self.is_link?
            self.active_paths.each do |path|
              return true if path.is_a?(Regexp) && (request.fullpath.split('?').first =~ path || request.url.split('?').first =~ path)
              return true if path.is_a?(String) && (request.fullpath.split('?').first == path || request.url.split('?').first == path)
            end
            return request.fullpath.split('?').first == self.destination || request.url.split('?').first == self.destination if self.active_paths.empty?
          end
        end

        def on_valid_level?(levels, current_level)
          levels.nil? || levels.empty? || levels_to_i(levels).include?(current_level-1)
        end

        def levels_to_i(levels_in_words)
          levels_in_words.map{ |word| word.is_a?(Symbol) ? @@level_options.index(word.to_sym) + 1 : word } if levels_in_words
        end

        private
        def render_as_link(request, options = {})
          if self.is_link?
            #... todo
          end
        end

        def render_as_group(request, options = {})
          if self.is_group?
            #... todo
          end
        end
      end
    end
  end
end
