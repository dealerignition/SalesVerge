class SampleCheckout < ActiveRecord::Base
  belongs_to :sample
  belongs_to :customer
  belongs_to :user
  belongs_to :sample_checkout_set

  validates_presence_of :checkout_time
  validates_presence_of :sample_id
  
  def checktime
    if self.checkin_time.present?
      checktime = self.checkin_time
    else
      checktime = self.checkout_time
    end
  end
  
end

