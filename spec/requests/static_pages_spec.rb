require 'spec_helper'

describe "StaticPages" do

	let(:base_title) { "Communicating Website" }

  describe "Home page" do

    it "should have the content 'Chirp App'" do
      visit root_path
      expect(page).to have_content('Chirp App')
    end

    it "should have the title 'Home'" do
    	visit root_path
    	expect(page).to have_title("Home | #{base_title}")
    end

    it "should not have a custom page title" do
      visit root_path
      expect(page).not_to have_title('Kolla')
    end
  end

  describe "Help page" do

  	it "Should have the content 'help'" do
  		visit help_path
  		expect(page).to have_content('Help')
  	end

  	it "should have the title 'Help'" do
  		visit help_path
  		expect(page).to have_title("Help | #{base_title}")
  	end
  end

  describe "About page" do

  	it "Should have the content 'about'" do
  		visit about_path
  		expect(page).to have_content('About Us')
  	end

  	it "should have the title 'About Us'" do
  		visit about_path
  		expect(page).to have_title("About Us | #{base_title}")
  	end
  end

  describe "Contact page" do

  	it "should have the content 'contact'" do
  		visit contact_path
  		expect(page).to have_content('Contact Us')
  	end

  	it "should have the title 'Contact Us'" do
  		visit contact_path
  		expect(page).to have_title("Contact Us | #{base_title}")
  	end
  end

end
