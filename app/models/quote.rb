class Quote < ActiveRecord::Base
  validates_presence_of :customer_id
  
  has_many :charges
  belongs_to :customer

  def total
    total = 0

    charges.each do |c|
      total += c.total
    end

    total.round 2
  end
end
