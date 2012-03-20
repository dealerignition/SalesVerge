class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  belongs_to :dealer
  has_many :appointments
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
end
