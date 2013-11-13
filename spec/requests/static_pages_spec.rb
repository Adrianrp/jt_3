require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the right title" do
	  visit '/static_pages/home'
	  expect(page).to have_title("Jespers Torvekøkken")
	end

	it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Menus page" do

    it "should have the content 'Menus'" do
      visit '/static_pages/menus'
      expect(page).to have_content('menus')
    end

    it "should have the right title" do
	  visit '/static_pages/menus'
	  expect(page).to have_title("Jespers Torvekøkken | Menus")
	end
  end

  describe "Buffets page" do

    it "should have the content 'Buffets'" do
      visit '/static_pages/buffets'
      expect(page).to have_content('buffets')
    end

    it "should have the right title" do
	  visit '/static_pages/buffets'
	  expect(page).to have_title("Jespers Torvekøkken | Buffets")
	end
  end
end