class Dealer < ActiveRecord::Base
  has_many :users
  has_many :stores
  
  validates_presence_of :name
end
