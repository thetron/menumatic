require 'spec_helper'

describe Menumatic::Navigation::Item::Base do
  before :each do
    @item = Menumatic::Navigation::Item::Base.new()
  end

  it "should have items" do 
    @item.respond_to?(:items).should == true
    @item.items.is_a?(Array).should == true
  end

  it "should have html options" do
    @item.respond_to?(:html_options).should == true
    @item.html_options.is_a?(Hash).should == true
  end

  it "should have wrapper options" do
    @item.respond_to?(:wrapper_options).should == true
    @item.wrapper_options.is_a?(Hash).should == true
  end

  it "should test if it is a link" do
    @item.respond_to?(:is_link?).should == true
  end

  it "should test if it is a group" do
    @item.respond_to?(:is_group?).should == true
  end

  it "should raise an error if a navigation is not found" do
    (render :navigation => :application).should raise_error(Menumatic::NavigationNotFound)
  end

  it "should call super on render, if navigation is unspecified" do
    #(render 'example_partial').should raise_error
    false
  end
end
