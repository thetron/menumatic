module Menumatic
  # A general Menumatic Exception
  class Error < StandardError; end

  # Raised when a navigation cannot be found, usually from load_navigation
  class NavigationNotFound < Error; end
end
