class SampleCheckoutSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  has_many :sample_checkouts
  
  validates_presence_of :customer_id
  validates_presence_of :user_id
  
  def self.send_long_checkout_set_notification
    sample_sets_out = SampleCheckoutSet.find_by_sql(
                        'select sample_checkout_sets.*, min(sample_checkouts.id)
                        from sample_checkout_sets
                        inner join users
                          on user_id = users.id
                        inner join sample_checkouts
                          on sample_checkout_sets.id = sample_checkouts.sample_checkout_set_id
                        where sample_checkout_sets.checkin_time is null 
                          and (sample_checkout_sets.notifications_received is null or sample_checkout_sets.notifications_received < 1) 
                          and (current_date - sample_checkout_sets.checkout_time::date) > users.reminder_interval_days
                        group by sample_checkout_sets.id, sample_checkout_sets.notifications_received, sample_checkout_sets.created_at, 
                          sample_checkout_sets.updated_at, sample_checkout_sets.customer_id, sample_checkout_sets.user_id')
    sample_sets_out.each do |s|
      sample_checkouts = s.sample_checkouts
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
