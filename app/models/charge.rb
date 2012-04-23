class Charge < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :description
  validates_presence_of :quantity
  validates_presence_of :price

  belongs_to :quote

  def total
    (quantity * price).round 2
  end
end
