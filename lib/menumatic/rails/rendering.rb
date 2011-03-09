module ActionView
  module Rendering
    def render_with_navigation_option(options = {}, locals = {}, &block)
      if options.has_key? :navigation
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
