class Quote < ActiveRecord::Base
  has_many :charges, :dependent => :destroy
  belongs_to :customer
  belongs_to :user
  
  validates_presence_of :user_id

  def total
    total = 0

    charges.each do |c|
      total += c.total
    end

    total.round 2
  end
  
  def charge_total
    charge_total = 0
    self.charges.each do |charge|
      charge_total += (charge.price * charge.quantity)
    end
    charge_total
  end
end
