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
