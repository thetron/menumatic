module Menumatic
  module Helpers
    module NavigationHelper
      @levels = [:primary, :secondary, :tertiary, :quarternary, :quinary]

      def navigation(ids, options = {})
        options[:start_level] ||= :primary # level to start building from
        options[:end_level] ||= nil # last level to render
        options[:level] ||= nil # single level to render, overrides any other level settings

        ids = Array(ids)
        navigation_id = ids.first

        if Rails.env == "development"
          Menumatic::Navigation::Base.destroy_all
          load "app/navigation/#{navigation_id}_navigation.rb"
        end

        navigation = Menumatic::Navigation::Base.get(navigation_id)
        render_list(navigation.items, 1, true)
      end

      private
      def render_list(items, level, render_children = false)
        has_active = render_children
        html_class = "level_#{level.to_s}"
        html_class += " application navigation" if level == 1
        if items && items.count > 0
          list = content_tag(:ul, items.map do |item| 
            has_active = true if item.is_active?(request)
            content_tag(:li, render_item(item, level))
          end.join("").html_safe, :class => html_class)
        end
        has_active ? list : nil 
      end

      def render_item(item, level)
        children = render_list(item.items, level + 1, item.is_active?(request))
        if children
          item.render(request, :active => true) + children
        else
          item.render(request)
        end
      end

    end
  end
end
