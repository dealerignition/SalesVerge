class Dealer < ActiveRecord::Base
  has_many :users
  
  validates_presence_of :name
  validates_presence_of :logo
end
