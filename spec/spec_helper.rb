require 'rubygems'
require 'bundler/setup'

require 'capybara'
require 'action_controller'
require 'menumatic'

RSpec.configure do |config|
  config.before :each do
    @request = mock(:request)
    @request.stub!(:fullpath).and_return("/search")
    @request.stub!(:url).and_return("http://test.menumatic.com/search")
  end
end
