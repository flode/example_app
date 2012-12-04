require 'spec_helper'
describe "Static pages", :type => :controller do
  describe "Home page" do
    it "should have the content 'Example App'" do
      visit '/static_pages/home'
      page.should have_content('Example App')
      page.should have_title(full_title(""))
    end
  end

  describe 'Help' do
    it "should have content" do
      visit '/static_pages/help'
      page.should have_content("w")
    end
  end
end
