class Holding < ActiveRecord::Base
  belongs_to :portfolio
  has_many :transactions
  attr_accessible :ticker, :total_cost, :total_shares, :total_value
  validates :ticker, :presence => true
end
