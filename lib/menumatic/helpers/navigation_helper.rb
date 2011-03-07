module Menumatic
  module Helpers
    module NavigationHelper
      def navigation(navigation_id = "application", options = {})
        options[:level] ||= nil # single level to render, overrides any other level settings
        options[:levels] ||= [options[:level]].delete_if{ |l| l.blank? }

        options[:group] ||= nil
        options[:groups] ||= [options[:groups]].delete_if{ |g| g.blank? }

        # Reload the navigation. Inefficient, but allows for the use of
        # normal if/unless in navigation structure, instead of Procs.
        Menumatic::Navigation::Base.destroy_all
        load "app/navigation/#{navigation_id}_navigation.rb"

        navigation = Menumatic::Navigation::Base.get(navigation_id)
        navigation.root.render(request, options)
      end

      def navigation_group(navigation_id, group_id, options = {})
        options = options.merge({:group => group_id})
        navigation(navigation_id, options)
      end
    end
  end
end
