class SentEmail < ActiveRecord::Base
  belongs_to :customer
  
  validates_presence_of :customer_id
  validates_presence_of :type
  
  attr_accessible :customer_id, :type
  
end
