class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.float :cost
      t.float :shares
      t.references :holding

      t.timestamps
    end
    add_index :transactions, :holding_id
  end
end
