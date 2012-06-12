class AppRequest < ActiveRecord::Base
  
  validates_presence_of :email
  validates :email, :email => { :mx => true }
  
end
