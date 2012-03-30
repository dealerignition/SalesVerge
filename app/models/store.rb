class Store < ActiveRecord::Base
  validates_presence_of :dealer_id
  belongs_to :dealer
  has_many :samples
end
