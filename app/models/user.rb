class User < ActiveRecord::Base
  ROLES = ["admin", "user"]
  before_validation :downcase_email

  authenticates_with_sorcery!

  has_many :company_users
  has_many :companies, :through => :company_users

  has_many :quotes, :dependent => :destroy
  has_many :sample_checkouts, :dependent => :destroy
  has_many :customers, :dependent => :destroy
  has_many :notes, :dependent => :destroy

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, :email => { :mx => true }
  validates_presence_of :role
  validates_inclusion_of :role, :in => ROLES
  validates_attachment_size :avatar, :in => 0..2000.kilobytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  has_attached_file :avatar,
    :styles => { :thumb => "100x100#" },
    :storage => :s3,
    :s3_credentials => "config/s3.yml",
    :path => "/:style/:id/:filename"

  def admin?
    role == "admin"
  end

  def owner?
    company_users.first.role == "owner"
  end

  def salesrep?
    company_users.first.role == "salesrep"
  end

  def company
    companies.first
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

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

end
