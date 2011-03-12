require 'spec_helper'

describe Menumatic::Navigation::Item::Group do
  before :each do
    # build a reasonably complex navigation and ensure that it's
    # properly stored for retreival
  end

  it "should be reloadable from it's ID"
  it "should reload between renders"
  it "should have a depth of 1 if no items are active"
  it "should have a depth of 1 if a first-level child is active"
  it "should have a depth of 2 if a second-level child is active"
  it "should have a depth of 3 if a third-level child is active"
  it "should have each level labelled in sequence starting at 1"
  it "should be able to display all links"
  it "should be able to render a different list tag"
  it "should be able to render a different item tag"
  it "should render different "
end
