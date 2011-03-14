module Menumatic
  # A general Menumatic Exception
  class Error < StandardError; end

  # Raised when a navigation cannot be found, usually from load_navigation
  class NavigationNotFound < Error


    def initialize(navigation = nil)
      @navigation = navigation
      @default_message = "No navigation not specified in call to render()."
    end

    def to_s
      if @navigation
        "Navigation file not found: #{@navigation}"
      else
        @default_message
      end
    end
  end
end
