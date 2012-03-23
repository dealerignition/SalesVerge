class Dealer < ActiveRecord::Base
  has_many :users
  
  validates_presence_of :name
  
  accepts_nested_attributes_for :users
end
