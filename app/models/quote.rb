class Quote < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user

  has_many :charges, :dependent => :destroy

  validates_presence_of :user_id

  def total
    charges.select("SUM(quantity * price) as sum").first.sum
  end

end
