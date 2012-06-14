class Sample < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :dealer_sample_id

  

  belongs_to :company
  has_many :sample_checkouts, :dependent => :destroy
end
