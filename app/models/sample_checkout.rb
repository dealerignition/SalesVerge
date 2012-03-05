class SampleCheckout < ActiveRecord::Base
  
  validates_presence_of :customer_id
  validates_presence_of :sample_id
  
  belongs_to :sample
  belongs_to :customer
  
end
