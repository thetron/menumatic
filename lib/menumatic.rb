module Menumatic
  module Helpers
    autoload :NavigationHelper, 'menumatic/helpers/navigation_helper'
    ActionController::Base.helper(Menumatic::Helpers::NavigationHelper)
  end

  module Navigation
    module Group
      autoload :Base, 'menumatic/navigation/group'
    end
    module Item
      autoload :Renderers, 'menumatic/navigation/item/renderers'
      autoload :Navigators, 'menumatic/navigation/item/navigators'
      autoload :Base, 'menumatic/navigation/item'
    end
    autoload :Base, 'menumatic/navigation'
  end
end
