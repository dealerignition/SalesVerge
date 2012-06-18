class SampleCheckout < ActiveRecord::Base
  belongs_to :sample
  belongs_to :customer
  belongs_to :user

  validates_presence_of :checkout_time
  validates_presence_of :sample_id
  
  def self.send_long_checkout_notification
    Customer.where("id in (?)", SampleCheckout.where(:checkin_time => nil).pluck(:customer_id).uniq).find_each do |c|
      sample_checkouts = c.sample_checkouts.where(
        "checkout_time < ?", c.sample_checkouts.last.user.reminder_interval_days.days.ago).where(
        "notifications_received < ?", 1).all
      CustomerMailer.long_checkout_notification(sample_checkouts).deliver unless sample_checkouts.empty?
      UserMailer.long_checkout_notification(sample_checkouts).deliver unless sample_checkouts.empty?
    end
  end
  
  def checktime
    if self.checkin_time.present?
      checktime = self.checkin_time
    else
      checktime = self.checkout_time
    end
  end
  
end

