# Menumatic

Menumatic is a _Rails 3 exclusive_ gem which aids in developing HTML
navigation menus.

__Please note__ menumatic is still in alpha however all the features mentioned in the readme should be working as expected - at the moment we're focussed on improving test coverage to bring us up to a proper, full release.

## Philosophy

When designing Menumatic, I wanted a way in which I could remove
navigation logic from the view all together, but also keep configuration
to a bare minimum and (hopefully) stick to the principle of
'convention-over-configuration'.

Menumatic considers navigations to be more like models as opposed to
views. As such, navigations are defined in the `app/navigation`
directory, and rendered in the view with a simple helper method.


# Getting Started

Include the gem in your `Gemfile` like so:

    gem 'menumatic'

Then update your bundle:

    $ bundle

You can then get started by generating a new navigation:

    $ rails g menumatic:navigation

This will create the file `app/navigation/application_navigation.rb` which you can use to
define the structure of your navigation items.

If you want to use the bundled stylesheet (nothing fancy, but quite serviceable - enough to get you up and running), add the following to your
layout:

    <%= stylesheet_link_tag "application_navigation" %>


# Using Menumatic

Navigations are stored in `app/navigation`. The default navigation is
given a name of 'application', however you can specify the name in the
generator:

    $ rails g menumatic:navigation application

Which will generate a navigation called
`app/navigation/application_navigation.rb` and the basic stylesheet.

Inside your navigation file, you can then define the structure of your
navigation, here is an example taken from the [Menumatic example
application](http://github.com/thetron/menumatic-sample-application):

    navigate_to "Home", home_path, :active_on => [home_path, root_path]
    navigate_to "About", about_path
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
       <%= navigation :navigation => 'application' %>
      </nav>
    </header>

Which will give you a full-semantic, auto-highlighted navigation.


## Rendering specific navigation levels

By default, Menumatic displays your navigation as a set of nested
unordered lists. However, if you need to break up your layout, this is
easily achiveable:


    # app/views/layouts/application.html.erb
    <!-- snip -->
    <header>
      <nav>
       <%= render :navigation => 'application', :level => :primary %>
      </nav>
    </header>

    <div class="sub_navigation">
      <%= render :navigation => application, :levels => [:secondary, :tertiary] %>
    </div>

The above example would render the top-level navigation in the
`<header>` and everything else in the `sub_navigation` div below.

__Note:__ numbers are also acceptable parameters here, where 1 is the primary level.


## Sitemap generation

Menumatic can also optionally generate a sitemap.xml. To include a

sitemap in your site, simply add this line to your `config/routes.rb`

    sitemap_for :application # or the name of your navigation


# Todo

I have some big ideas for Menumatic, but there should be enough
functionality in there to service the vast majority of web apps. If you have
any feature requests or questions, feel free to [open an issue](http://github.com/thetron/menumatic/issues) - I'd love to get
some feedback!

This is what I have planned for some future releases:

* __Tests__ I know I should've been doing this properly from the start,
  but i'm still trying to get my head around TDD. However, this is definitely a
  big priority for Menumatic.

* __More configuration options__


# Credits

I'd like to thank [Jordan Lewis](http://github.com/jordan-lewis) for his CSS styling skills.
