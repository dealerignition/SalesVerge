class Customer < ActiveRecord::Base
  belongs_to :user
  has_one :company, :through => :user

  validates_presence_of :email
  validates :email, :email => { :mx => true }
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :user_id
  validates_uniqueness_of :email, :for => :company

  has_many :sample_checkouts, :dependent => :destroy
  has_many :quotes, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :sent_emails, :dependent => :destroy

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

end
