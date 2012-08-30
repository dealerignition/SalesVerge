class User < ActiveRecord::Base
  ROLES = ["admin", "user"]
  before_validation :downcase_email
  after_create :add_dummy_data

  authenticates_with_sorcery!

  has_many :company_users
  has_many :companies, :through => :company_users

  has_many :quotes, :dependent => :destroy
  has_many :sample_checkouts, :dependent => :destroy
  has_many :customers, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  
  has_many :sample_checkout_sets, :dependent => :destroy

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  has_many :recieved_invitations, :class_name => 'Invitation', :foreign_key => 'recipient_id'

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, :email => { :mx => true }
  validates_presence_of :phone
  validates_presence_of :role
  validates_inclusion_of :role, :in => ROLES
  validates_attachment_size :avatar, :in => 0..2000.kilobytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  has_attached_file :avatar,
    :styles => { :thumb => "100x100#" },
    :storage => :s3,
    :s3_credentials => "config/aws.yml",
    :path => "/:style/:id/:filename"

  def increase_sign_in_count_and_update_last_sign_in
    self.sign_in_count += 1
    self.last_sign_in = Time.now
    self.save
  end
  
  def active?
    company_users.first.active?
  end

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
  
  def add_dummy_data
    first_customer = Customer.create(
      :first_name   =>    "Jane",
      :last_name    =>    "Doe",
      :email        =>    self.email,
      :user_id      =>    self.id
    )
    Customer.create(
      :first_name   =>    "John",
      :last_name    =>    "Smith",
      :email        =>    (self.email.split('@')).join("+test@"),
      :user_id      =>    self.id
    )
    quote = Quote.create(
      :customer_id  =>    first_customer.id,
      :user_id      =>    self.id,
    )
    Charge.create(
      :quote_id     =>    quote.id,
      :date         =>    Date.today,
      :description  =>    "Product 1",
      :quantity     =>    1,
      :price        =>    350
    )
    Charge.create(
      :quote_id     =>    quote.id,
      :date         =>    Date.today,
      :description  =>    "Product 2",
      :quantity     =>    1,
      :price        =>    450
    )
    Charge.create(
      :quote_id     =>    quote.id,
      :date         =>    Date.today,
      :description  =>    "Product 3",
      :quantity     =>    3,
      :price        =>    12.95
    )
  end

  private

  def downcase_email
    self.email.downcase! if self.email
  end

  def self.send_daily_digest
    User.all.each do |user|
      if user.owner? && user.receives_nightly_digest
        UserMailer.daily_digest(user).deliver
      end
    end
  end
  
  def self.send_low_activity_mailer
    User.all.each do |user|
      if user.created_at >= 4.days.ago && user.customers.count <= 2 && user.receive_low_activity_mailer == true
        UserMailer.low_activity(user).deliver
        user.receive_low_activity_mailer = false
        user.save
      end
    end
  end

end
