module Menumatic
  class Engine < Rails::Engine
    ActionController::Base.helper(Menumatic::Helpers::NavigationHelper)
  end
end
