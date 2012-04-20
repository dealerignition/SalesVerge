class Store < ActiveRecord::Base
  before_validation :smart_add_url_protocol
  validates_presence_of :dealer_id
  
  belongs_to :dealer
  has_many :samples, :dependent => :destroy
  
  protected

  def smart_add_url_protocol
    unless self.website[/^http:\/\//] || self.website[/^https:\/\//]
      self.website = 'http://' + self.website
    end
  end
  
end
