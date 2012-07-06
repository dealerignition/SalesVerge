class AppRequest < ActiveRecord::Base
  
  validates_presence_of :email
  validates :email, :email => { :mx => true }
  
  def self.send_todays_app_requests
    @todays_app_requests = AppRequest.where("created_at > ?", 24.hours.ago)
    AdminMailer.todays_app_requests(@todays_app_requests).deliver
  end
  
end
