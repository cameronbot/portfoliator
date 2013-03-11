require 'spec_helper'

feature "Create transactions for a holding in a portfolio" do
  before do
    samplePortfolio = Factory(:portfolio, :name => "Sample test portfolio")
    sampleHolding1 = Factory(:holding, :ticker => "MMM", :portfolio => samplePortfolio)
    sampleHolding2 = Factory(:holding, :ticker => "GE", :portfolio => samplePortfolio)
    visit "/"
    click_link "Sample test portfolio"
  end

  scenario "can create a transaction for a holding" do
    find(:xpath, "//tr[td[contains(.,'MMM')]]/td/a", :text => 'Add').click
    fill_in "transaction_cost", :with => "100.00"
    fill_in "transaction_shares", :with => "10"
    fill_in "transaction_date", :with => "05/23/2012"
    click_button "Create Transaction"
    page.should have_content("Transaction for MMM added.")
  end

  scenario "can not add a transaction with empty fields" do
    find(:xpath, "//tr[td[contains(.,'MMM')]]/td/a", :text => 'Add').click
    fill_in "transaction_cost", :with => ""
    fill_in "transaction_shares", :with => ""
    fill_in "transaction_date", :with => ""
    click_button "Create Transaction"
    page.should have_content("Transaction was not saved.")
    page.should have_content("Cost can't be blank")
    page.should have_content("Shares can't be blank")
    page.should have_content("Date can't be blank")
  end

  scenario "multiple transactions will be reflected as a sum value in the holding" do
    find(:xpath, "//tr[td[contains(.,'MMM')]]/td/a", :text => 'Add').click
    fill_in "transaction_cost", :with => "100.00"
    fill_in "transaction_shares", :with => "10"
    fill_in "transaction_date", :with => "05/23/2012"
    click_button "Create Transaction"
    page.should have_content("Transaction for MMM added.")

    find(:xpath, "//tr[td[contains(.,'MMM')]]/td/a", :text => 'Add').click
    fill_in "transaction_cost", :with => "200.00"
    fill_in "transaction_shares", :with => "20"
    fill_in "transaction_date", :with => "05/23/2012"
    click_button "Create Transaction"
    page.should have_content("30") # total shares
    page.should have_content("300") # total cost
  end
end
