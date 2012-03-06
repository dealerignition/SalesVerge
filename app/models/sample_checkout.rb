class SampleCheckout < ActiveRecord::Base
  belongs_to :sample
  belongs_to :customer

  validates_presence_of :checkout_time
end
