class Customer < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :user_id

  has_many :sample_checkouts, :dependent => :destroy
  has_many :appointments, :dependent => :destroy
  has_many :estimates, :dependent => :destroy
  has_many :notes, :dependent => :destroy

  def full_name
    "#{ first_name } #{ last_name }"
  end

  def timeline_stream
    estimates + sample_checkouts + notes
  end
end
