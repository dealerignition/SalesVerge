class SampleCheckout < ActiveRecord::Base
  belongs_to :sample
  belongs_to :customer
  belongs_to :user

  validates_presence_of :checkout_time
  validates_presence_of :sample_id
end
