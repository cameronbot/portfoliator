class Portfolio < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :holdings, :dependent => :destroy
end
