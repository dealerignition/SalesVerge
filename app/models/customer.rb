class Customer < ActiveRecord::Base
  
  validates_presence_of :email
  
  has_many :sample_checkouts
  
end
