class Dealer < ActiveRecord::Base
  before_save :singularize_sample_name
  
  has_many :users, :dependent => :destroy
  has_many :stores, :dependent => :destroy
  
  validates_presence_of :name
  accepts_nested_attributes_for :stores
  
  def singularize_sample_name
    self.sample_name = sample_name.singularize if self.sample_name
  end
end
