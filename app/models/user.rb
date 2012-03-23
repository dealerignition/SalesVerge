class User < ActiveRecord::Base
  before_save :downcase_email
  
  authenticates_with_sorcery!
  
  belongs_to :dealer
  has_many :appointments
  has_many :quotes
  has_many :sample_checkouts
  has_many :customers
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :dealer_id, :active

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def downcase_email
    self.email.downcase! if self.email
  end
end
