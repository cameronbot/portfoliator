class AddPricesLastUpdatedToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :price_updated, :timestamp
  end
end
