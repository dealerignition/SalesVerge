class Sample < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :dealer_sample_id
  
  belongs_to :store
  has_many :sample_checkouts, :dependent => :destroy
end
