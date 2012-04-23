class Quote < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user

  has_many :charges, :dependent => :destroy

  validates_presence_of :user_id

  def total
    total = 0

    charges.each do |c|
      total += c.total
    end

    total.round 2
  end

end
