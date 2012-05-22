class SentEmail < ActiveRecord::Base
  belongs_to :customer
  
  validates_presence_of :customer_id
  validates_presence_of :notification_type
  
  attr_accessible :customer_id, :notification_type, :notification_type_id
  
end
