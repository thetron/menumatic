require 'spec_helper'

describe Menumatic::Navigation::Item::Renderers do
  before :each do
    @label = "Search"
    @destination = @request.fullpath
    @options = {}
    @link = Menumatic::Navigation::Item::Link.new(@label, @destination, @options)
  end

  it "should render a list item containing only a link when it has no children" do
    html = Capybara.string @link.render(@request)
    html.should have_selector('li a')
    html.should_not have_selector('li ul')
  end

  it "should render a list item containing only a link when it has no active descendants" do
    @link.navigate_to("Child link", "/page/something_unrelated")
    @link.destination = "/page"
    html = Capybara.string @link.render(@request)
    html.should have_selector('li a')
    html.should_not have_selector('li ul')
  end

  it "should render a list item containing an active link when active" do
    html = Capybara.string @link.render(@request)
    html.should have_selector('li.active a')
  end

  it "should render a list item containing a list of its children when active" do
    @link.navigate_to("Child link 1", "/page/child_1")
    @link.navigate_to("Child link 2", "/page/child_2")
    html = Capybara.string @link.render(@request)
    html.should have_selector('li ul li a[href="/page/child_1"]')
    html.should have_selector('li ul li a[href="/page/child_2"]')
  end

  it "should render a list item containing an active link and a list of its children when it has an active descendant" do
    @link.destination = "/home"

    @link.navigate_to "Child link 1", "/page/child_1" do |child|
      child.navigate_to "Search", @request.fullpath
    end
    @link.navigate_to "Child link 2", "/page/child_2"

    html = Capybara.string @link.render(@request)
    html.should have_selector('li > ul.active')
    html.should have_selector("li > ul.active > li.active > ul.active > li.active > a[href='#{@request.fullpath}']")
  end
end
