module ActionView
  module Rendering

    # Aliased function for standard rails render function. Adds an option
    # for :navigation, which will render the selected navigation from the
    # `app/navigation` directory.
    def render_with_navigation_option(options = {}, locals = {}, &block)
      if options.respond_to?(:has_key?) && options.has_key?(:navigation)
        navigation_id = options[:navigation]
        options.delete(:navigation)
        menumatic(navigation_id, options)
      else
        render_without_navigation_option(options, locals, &block)
      end
    end
    alias_method_chain :render, :navigation_option
  end
end
