class Customer < ActiveRecord::Base
  belongs_to :user
  has_one :company, :through => :user

  validates_presence_of :email
  validates :email, :email => { :mx => true }
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :user_id
  before_save :verify_uniqueness_of_email_within_company

  has_many :sample_checkouts, :dependent => :destroy
  has_many :quotes, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :sent_emails, :dependent => :destroy
  
  has_many :sample_checkout_sets, :dependent => :destroy

  has_one :customer_extension, :dependent => :destroy

  def full_name
    "#{ first_name } #{ last_name }"
  end

  def timeline_stream
    quotes + sample_checkouts + notes
  end

  def has_quotes?
    Rails.cache.fetch("customer_#{id}_has_quotes") { quotes.any? }
  end

  def has_sample_checkouts?
    Rails.cache.fetch("customer_#{id}_has_sample_checkouts") { sample_checkouts.any? }
  end

  def verify_uniqueness_of_email_within_company
    if self.user.company != nil
      ids = self.user.company.users.collect { |user| user.id }
      taken_emails = Customer.where("user_id in (?)", ids).collect { |cust| cust.email }
      
      if email_changed?
        if taken_emails.include?(self.email)
          errors.add(:base, "Email already taken")
          return false
        end
      end
    end
    nil
  end
  
end
