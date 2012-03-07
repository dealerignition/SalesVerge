class Appointment < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :time
  validates_presence_of :customer_id
  
  belongs_to :customer
end
