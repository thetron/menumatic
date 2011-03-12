require 'spec_helper'

describe Menumatic::Navigation::Item::Group do
  before :each do
    @group = Menumatic::Navigation::Item::Group.new(:test_group, {})
    @group.navigate_to("Home", "/home")
    @group.navigate_to("About", "/about")
    @group.navigate_to("Contact us", "/contact_us")
  end

  it "should have a group ID" do
    @group.respond_to?(:group_id).should == true
  end

  it "should render a list containing its child items" do
    html = Capybara.string @group.render(@request)
    html.should have_selector('ul.level_1')
    html.should have_selector('ul.level_1 > li > a[href="/home"]')
    html.should have_selector('ul.level_1 > li > a[href="/about"]')
    html.should have_selector('ul.level_1 > li > a[href="/contact_us"]')
  end
end
