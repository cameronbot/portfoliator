class Transaction < ActiveRecord::Base
  belongs_to :holding
  attr_accessible :cost, :date, :shares
  validates :cost, :presence => true
  validates :date, :presence => true
  validates :shares, :presence => true
end
