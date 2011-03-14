require 'spec_helper'

describe Menumatic::Helpers::NavigationHelper do
  before :each do
    @navigation = Menumatic::Navigation::Base::new(:application).root
    @navigation.navigate_to "Home", "/home"
    @navigation.navigate_to "Store", "/store" do |store|
      store.navigate_to "Categories", "/store/categories" do |categories|
        categories.navigate_to "Blue things", "/store/categories/blue"
        categories.navigate_to "Red things", "/store/categories/red"
      end
      store.navigate_to "Specials", "/store/specials"
    end
    @navigation.navigate_to "Contact us", "/contact_us"
  end

  it "should have a depth of 1 if no items are active" do
    @navigation.depth_count(@request).should == 1
  end


  it "should have a depth of 1 if a first-level child is active" do
    @request.stub!(:fullpath).and_return("/contact_us")
    @request.stub!(:url).and_return("http://test.menumatic.com/contact_us")
    @navigation.depth_count(@request).should == 1
  end

  it "should have a depth of 2 if a second-level child is active" do
    @request.stub!(:fullpath).and_return("/store/specials")
    @request.stub!(:url).and_return("http://test.menumatic.com/store/specials")
    @navigation.depth_count(@request).should == 2
  end

  it "should have a depth of 3 if a third-level child is active" do
    @request.stub!(:fullpath).and_return("/store/categories/red")
    @request.stub!(:url).and_return("http://test.menumatic.com/store/categories/red")
    @navigation.depth_count(@request).should == 3
  end

  it "should have each level labelled in sequence starting at 1" do
    @request.stub!(:fullpath).and_return("/store/categories/red")
    @request.stub!(:url).and_return("http://test.menumatic.com/store/categories/red")
    Capybara::string(@navigation.render(@request)).should have_selector("ul.level_1 > li > ul.level_2 > li ul.level_3")
  end

  it "should be able to display all links" do
    html = Capybara::string(@navigation.render(@request, :show => :all))
    html.should have_selector('a[href="/home"]')
    html.should have_selector('a[href="/store"]')
    html.should have_selector('a[href="/store/categories"]')
    html.should have_selector('a[href="/store/categories/blue"]')
    html.should have_selector('a[href="/store/categories/red"]')
    html.should have_selector('a[href="/store/specials"]')
    html.should have_selector('a[href="/contact_us"]')
  end

  it "should be able to render a different list tag" do
    html = Capybara::string(@navigation.render(@request, :wrapper_tag => :nav))
    html.should have_selector('nav.level_1')
  end

  it "should be able to render a different item tag" do
    html = Capybara::string(@navigation.render(@request, :item_tag => :span))
    html.should have_selector('ul.level_1 > span > a[href="/home"]')
  end
end
