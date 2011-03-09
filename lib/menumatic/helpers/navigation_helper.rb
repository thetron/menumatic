module Menumatic
  module Helpers
    module NavigationHelper
      def render_navigation(navigation_id = :application, options = {})
        options[:level] ||= nil # single level to render, overrides any other level settings
        options[:levels] ||= [options[:level]].delete_if{ |l| l.blank? }

        options[:group] ||= nil
        options[:groups] ||= [options[:groups]].delete_if{ |g| g.blank? }

        options[:class] ||= ""
        options[:class] += "navigation #{navigation_id}"

        navigation = Menumatic::Navigation::Base.load_navigation(navigation_id)
        navigation.root.render(request, options)
      end

      def sitemap(document, navigation_id = "application", options = {})
        navigation = load_navigation(navigation_id)
        navigation.root.render_sitemap(document, request, options)
      end

      # refactor this into a class method on Menumatic::Navigation::Base

      #def navigation_group(navigation_id, group_id, options = {})
      #  options = options.merge({:group => group_id})
      #  navigation(navigation_id, options)
      #end
    end
  end
end
