require 'menumatic/helpers/navigation_helper'
require 'menumatic/navigation'
require 'menumatic/navigation/item'

module Menumatic
  ActionController::Base.helper(Menumatic::Helpers::NavigationHelper)
end
