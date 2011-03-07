# Menumatic

Menumatic is a _Rails 3 exclusive_ gem which aids in developing HTML
navigation menus.

## Philosophy

Menumatic takes a slightly different approach to other navigation gems,
in that the structure of the menu is considered to be more 'M' than 'V'
in the MVC world. This is because given any view, we may only want to
display _parts_ of a particular navigation, such as sub-navigations and
sidebars, for which there is a simple view helper.

This results in simple, clean and easy-to-read code that you can
leverage in any part of your Rails app.

# Getting Started

Include the gem in your `Gemfile` like so:

    gem 'menumatic'

Then update your bundle:

    $ bundle

You can then get started by generating a new navigation:

    $ rails g navigation

This will create the file `app/navigation/application_navigation.rb` which you can use to
define the structure of your navigation items.

If you want to use the bundled stylesheet (bland, but functional), add the following to your
layout:

    <%= stylesheet_link_tag "application_navigation" %>

# Using Menumatic

Navigations are stored in `app/navigation`. The default navigation is
given a name of 'application', however you can specify the name in the
generator:

    $ rails g navigation admin

Which will generate a navigation called 'admin'

Inside your navigation file, you can then define the structure of your
navigation, here is an example taken from the [Menumatic example
application](http://github.com/thetron/menumatic-sample-application):

    navigate_to "Home", home_path, :active_paths => [:home_path, :root_path]
    navigate_to "About", about_path do |about|
      about.navigate_to "History", about_history_path
      about.navigate_to "The team", about_the_team_path 
      about.navigate_to "Our vision", about_our_vision_path
    end
    navigate_to "Store", store_on_special_path do |store|
      store.navigate_to "On special", store_on_special_path
      store.navigate_to "Coming soon", store_coming_soon_path
      store.navigate_to "Categories", store_categories_path do |categories|
        categories.navigate_to "Shirts", store_categories_shirts_path
        categories.navigate_to "Pants", store_categories_pants_path
        categories.navigate_to "Hats", store_categories_hats_path
        categories.navigate_to "Accessories", store_categories_accessories_path
        categories.navigate_to "Sporks", store_categories_sporks_path
      end
    end
    navigate_to "Something", something_else_path
    navigate_to "Contact us", contact_us_path
    navigate_to "Admin", admin_path if current_user.is_admin?

When creating your navigation you effectively have two methods at your
disposal: `navigate_to` and `group`

`navigate_to` creates a navigation item in your menu, and works very
similar to Rails' built-in `link_to` helper. It also accepts a few other
options, which are listed below.

To display your navigation in your view, simply use the menumatic
helper:

    # app/views/layouts/application.html.erb
    <!-- snip -->
    <header>
      <nav>
       <%= navigation :application %>
      </nav>
    </header>

Which will give you a full-semantic, auto-highlighted navigation.


## Selective Rendering

By default, Menumatic displays your navigation as a set of nested
unordered lists. However, if you need to break up your layout, this is
easily achiveable:


    # app/views/layouts/application.html.erb
    <!-- snip -->
    <header>
      <nav>
       <%= navigation :application, :level => :primary %>
      </nav>
    </header>

    <div class="sub_navigation">
      <%= navigation :application, :levels => [:secondary, :tertiary] %>
    </div>

The above example would render the top-level navigation in the
`<header>` and everything else in the `sub_navigation` div below.


## Grouping

Menumatic also supports grouping navigation items together. By default,
groups nested in your navigation will not display as part of the normal
rendering, but only when you request them.

The best example of when this is useful is for developing a sidebar. Particularly in the case of a sidebar whose navigation items will vary, depending on the page.

__Please note__: grouping is not currently available, but is coming
_very_ soon.

## Credits

I'd like to thank [Jordan Lewis](http://github.com/jordan-lewis) for his CSS styling skills.
