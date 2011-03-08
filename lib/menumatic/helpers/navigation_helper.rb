module Menumatic
  module Helpers
    module NavigationHelper
      def navigation(navigation_id = "application", options = {})
        options[:level] ||= nil # single level to render, overrides any other level settings
        options[:levels] ||= [options[:level]].delete_if{ |l| l.blank? }

        options[:group] ||= nil
        options[:groups] ||= [options[:groups]].delete_if{ |g| g.blank? }

        options[:class] ||= ""
        options[:class] += "navigation #{navigation_id}"

        navigation = load_navigation(navigation_id)
        navigation.root.render(request, options)
      end

      def sitemap(document, navigation_id = "application", options = {})
        navigation = load_navigation(navigation_id)
        navigation.root.render_sitemap(document, options)
      end

      def load_navigation(navigation_id)
        # Eager load the requested navgation (allows for use of normal if/unless statements)
        Menumatic::Navigation::Base.destroy_all
        load "app/navigation/#{navigation_id}_navigation.rb"
        Menumatic::Navigation::Base.get(navigation_id)
      end

      def navigation_group(navigation_id, group_id, options = {})
        options = options.merge({:group => group_id})
        navigation(navigation_id, options)
      end
    end
  end
end
