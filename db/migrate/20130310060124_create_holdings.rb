class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.string :ticker
      t.float :total_cost
      t.float :total_value
      t.float :total_shares
      t.references :portfolio

      t.timestamps
    end
    add_index :holdings, :portfolio_id
  end
end
