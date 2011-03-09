module ActionView
  module Rendering
    def render_with_navigation_option(options = {}, locals = {}, &block)
      if options.has_key? :navigation
        navigation_id = options[:navigation]
        options.delete(:navigation)
        render_navigation(navigation_id, options)
      else
        render_without_navigation_option(options, locals, &block)
      end
    end
    alias_method_chain :render, :navigation_option
  end

  private
  def render_navigation(navigation_id = :application, options = {})
    puts "Navigation_id: #{navigation_id.to_s}"
    navigation_id = :application


    options[:level] ||= nil # single level to render, overrides any other level settings
    options[:levels] ||= [options[:level]].delete_if{ |l| l.blank? }

    options[:group] ||= nil
    options[:groups] ||= [options[:groups]].delete_if{ |g| g.blank? }

    options[:class] ||= ""
    options[:class] += "navigation #{navigation_id}"

    navigation = Menumatic::Navigation::Base.load_navigation(navigation_id)
    navigation.root.render(request, options)
  end
end
