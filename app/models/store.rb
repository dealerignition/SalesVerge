class Store < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :dealer
  has_many :samples
end

class Dealer
  has_many :stores
end
