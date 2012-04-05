class User < ActiveRecord::Base
  ROLES = ["owner", "admin", "salesrep"]
  before_save :downcase_email

  authenticates_with_sorcery!
  
  belongs_to :dealer

  has_many :appointments, :dependent => :destroy
  has_many :estimates, :dependent => :destroy
  has_many :sample_checkouts, :dependent => :destroy
  has_many :customers, :dependent => :destroy
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :phone, :message

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :role
  validates_inclusion_of :role, :in => ROLES
  
  scope :is_owner, where(:role => 'owner')

  def admin?
    role == "admin"
  end

  def owner?
    role == "owner"
  end

  def salesrep?
    role == "salesrep"
  end

  def full_name
    "#{ first_name } #{ last_name }"
  end
  
  private

  def downcase_email
    self.email.downcase! if self.email
  end
  
  def self.send_daily_digest
    User.is_owner.all.each do |user|
      UserMailer.daily_digest(user).deliver
    end
  end
  
end
