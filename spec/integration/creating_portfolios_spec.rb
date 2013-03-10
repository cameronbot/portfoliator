require 'spec_helper'

feature "Create portfolios" do
  before do
    visit "/"
    click_link "New Portfolio"
  end

  scenario "can create a new portfolio" do
    fill_in "Name", :with => "Testing Portfolio"
    click_button "Create Portfolio"
    page.should have_content("Portfolio created.")
  end

  scenario "can not create a new portfolio without a name" do
    click_button "Create Portfolio"
    page.should have_content("Portfolio not created.")
    page.should have_content("Name can't be blank")
  end
end
