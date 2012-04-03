class Dealer < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :stores, :dependent => :destroy
  
  validates_presence_of :name
  accepts_nested_attributes_for :stores
end
