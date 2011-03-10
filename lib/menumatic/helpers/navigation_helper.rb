module Menumatic
  module Helpers
    module NavigationHelper
      def menumatic(navigation_id = :application, options = {})
        options[:level] ||= nil # single level to render, overrides any other level settings
        options[:levels] ||= [options[:level]].delete_if{ |l| l.blank? }

        options[:group] ||= nil
        options[:groups] ||= [options[:groups]].delete_if{ |g| g.blank? }

        options[:class] ||= ""
        options[:class] = (options[:class].split(" ") + ["navigation #{navigation_id.to_s}"]).join(" ")

        navigation = Menumatic::Navigation::Base.load_navigation(navigation_id.to_sym)
        navigation.root.render(request, options)
      end

      def sitemap(document, navigation_id = "application", options = {})
        navigation = Menumatic::Navigation::Base.load_navigation(navigation_id)
        navigation.root.render_sitemap(document, request, options)
      end
    end
  end
end
