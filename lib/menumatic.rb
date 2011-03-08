module Menumatic
  module Helpers
    autoload :NavigationHelper, 'menumatic/helpers/navigation_helper'
    ActionController::Base.helper(Menumatic::Helpers::NavigationHelper)
  end

  module Navigation
    module Item
      autoload :Renderers, 'menumatic/navigation/item/renderers'
      autoload :Navigators, 'menumatic/navigation/item/navigators'
      autoload :Group, 'menumatic/navigation/item/group'
      autoload :Link, 'menumatic/navigation/item/link'
      autoload :Base, 'menumatic/navigation/item'
    end
    autoload :Base, 'menumatic/navigation'
  end

  #autoload :Mapper, 'menumatic/action_dispatch/routing/mapper'
  #autoload :SitemapController, '../app/controllers/menumatic
end

require 'menumatic/rails/routes'
require 'menumatic/engine'
