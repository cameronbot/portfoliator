require 'spec_helper'

feature "Create holdings in a portfolio" do
  before do
    sample1 = Factory(:portfolio, :name => "Sample test portfolio")
    sample2 = Factory(:portfolio, :name => "Another test portfolio")
    visit "/"
    click_link "Sample test portfolio"
    click_link "Add holding"
  end

  scenario "can create a holding in a portfolio" do
    fill_in "Ticker", :with => "PFE"
    click_button "Create Holding"
    page.should have_content("Holding added.")
  end

  scenario "can not create a new holding without a ticker" do
    click_button "Create Holding"
    page.should have_content("Holding not added.")
    page.should have_content("Ticker can't be blank")
  end
end
