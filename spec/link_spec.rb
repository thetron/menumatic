require 'spec_helper'

describe Menumatic::Navigation::Item::Link do

  before :each do
    @label = "Search"
    @destination = @request.fullpath
    @options = {}
    @link = Menumatic::Navigation::Item::Link.new(@label, @destination, @options)
  end

  it "should have a label" do
    @link.should respond_to(:label)
    @link.label.should == @label
  end

  it "should have a destination" do
    @link.should respond_to(:destination)
    @link.destination.should == @destination
  end

  it "should be a link" do
    @link.is_link?.should == true
  end

  it "should not be a group" do
    @link.is_group?.should == false
  end

  it "should be active when destination is the same as the request path" do
    @link.is_active?(@request).should == true
  end

  it "should not be active when destination is not the same as the request path" do
    @link.destination = "/home"
    @link.is_active?(@request).should == false
  end

  it "should be able to parent links" do
    @link.navigate_to("Contact us", "/contact_us")
    @link.items.first.is_link?.should == true
    @link.items.first.label.should == "Contact us"
    @link.items.first.destination.should == "/contact_us"
  end

  it "should be able to parent groups" do
    @link.group(:sidebar)
    @link.items.first.is_group?.should == true
    @link.items.first.group_id.should == :sidebar
  end
end
