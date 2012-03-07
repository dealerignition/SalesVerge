class Appointment < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :time
  validates_presence_of :customer_id
  validates_presence_of :status
  
  belongs_to :customer
end
