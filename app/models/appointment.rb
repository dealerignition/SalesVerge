class Appointment < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :time
  validates_presence_of :customer_id
  validates_presence_of :status
  validates_presence_of :user_id
  
  belongs_to :customer
  belongs_to :user
end
