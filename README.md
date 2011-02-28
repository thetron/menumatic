# Menumatic

Menumatic is a _Rails 3 exclusive_ gem which aids in developing HTML
navigation menus.

# Getting Started

Start by generating a new navigation

    $ rails g navigation

This will create the file `app/navigation/application_navigation.rb` which you can use to
define the structure of your navigation items.

If you want to include the bundled stylesheet, add the following to your
layout:

    <%= stylesheet_link_tag "application_navigation" %>

# Options

_todo_
