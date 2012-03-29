class Customer < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :user_id

  has_many :sample_checkouts
  has_many :appointments
  has_many :quotes
end
