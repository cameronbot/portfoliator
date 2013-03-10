class Holding < ActiveRecord::Base
  belongs_to :portfolio
  attr_accessible :ticker, :total_cost, :total_shares, :total_value
  validates :ticker, :presence => true
end
