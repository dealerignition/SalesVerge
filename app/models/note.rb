class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  
  validates_presence_of :user_id
  validates_presence_of :customer_id
end
