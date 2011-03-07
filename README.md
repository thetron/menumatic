# Menumatic

Menumatic is a _Rails 3 exclusive_ gem which aids in developing HTML
navigation menus.

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


# Philosophy

Menumatic takes a slightly different approach to other navigation gems,
in that the structure of the menu is considered to be more 'M' than 'V'
in the MVC world. This is because given any view, we may only want to
display _parts_ of a particular navigation, such as sub-navigations and
sidebars, for which there is a simple view helper.

This results in simple, clean and easy-to-read code that you can
leverage in any part of your Rails app.


# Using Menumatic

Navigations are stored in `app/navigation`. The default navigation is
given a name of 'application', however you can specify the name in the
generator:

    $ rails g navigation admin

Which will generate a navigation called 'admin'

Inside your navigation file, you can then define the structure of your
navigation, here is an example taken from the [Menumatic example
application](http://www.github.com/thetron/menumatic-test):

_todo_

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


# More Options

## Options for `navigate_to`

_todo_

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
      <%= navigation :application, :start_level => :secondary %>
    </div>

The above example would render the top-level navigation in the
`<header>` and everything else in the `sub_navigation` div below.


## Grouping

Menumatic also supports grouping navigation items together. By default,
groups nested in your navigation will not display as part of the normal
rendering, but only when you request them.

The best example of when this is useful is for developing a sidebar. Particularly in the case of a sidebar whose navigation items will vary, depending on the page. For example:

_todo_
