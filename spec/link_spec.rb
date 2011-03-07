require 'spec_helper'
require 'active_resource/http_mock'

describe Menumatic::Navigation::Item::Link do

  before :each do
    @label = "Search"
    @destination = "/search"
    @options = {}
    @link = Menumatic::Navigation::Item::Link.new(@label, @destination, @options)

    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/search', {}, ''
    end
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
    request = ActiveResource::Request.new(:get, @link.destination)
    @link.is_active?(request).should == true
  end

  it "should not be active when destination is not the same as the request path" do
    @link.is_active?(request).should == false
  end

  it "should be able to parent links"
  it "should be able to parent groups"

  it "should render a list item containing only a link when it has no children"
  it "should render a list item containing only a link when it has no active descendants"
  it "should render a list item containing an active link when active"
  it "should render a list item containing a list of its children when active"
  it "should render a list item containing an active link and a list of its children when it has an active descendant"
end
