# Menumatic - TODO

## Refactor

`Menumatic::Navigation::Item::Base` needs to become the superclass of the two navigator options:
- Menumatic::Navigation::Item::Group
- Menumatic::Navigation::Item::Link

The difference between these two, is that `Link` will have significanly
more attributes, and also have included
`Menumatic::Navigation::Item::Renderers`. Additionally, the 'root' of
any Menumatic::Navigation::Base, will be converted into a `Group` with
`id = :root`.

This will allow us to handle the render chain much more logically, and
hopefully produce some cleaner code.

## Selective Navigation rendering

This should be the next highest priority, and we need to consider how to
pass the requested groups and chain position through the render process,
to make sure no link is left behind.

## Sitemap generation

Create a helper method for the routes.rb file (similar to `devise_for`):

    sitemap :application

Which will create a route for sitemap.xml and automatically generate and
handle the requests that go through to it. The sitemap will be generated
from the navigation specified in the sitemap helper. This will include
all links and groups (except those not visible by default from
conditional effects).


