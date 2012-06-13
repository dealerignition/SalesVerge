class Company < ActiveRecord::Base
  has_many :company_users, :dependent => :destroy
  has_many :users, :through => :company_users
  has_many :customers, :through => :users
  
  before_validation :smart_add_url_protocol
  before_save :singularize_sample_name
  before_save :check_configuration

  validates_presence_of :name
  validates_presence_of :sample_name

  validates_attachment_size :logo, :in => 0..2000.kilobytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  has_attached_file :logo,
    :styles => { :large => "200x200>" },
    :storage => :s3,
    :s3_credentials => "config/s3.yml",
    :path => "/:style/:id/:filename"

  def singularize_sample_name
    self.sample_name = sample_name.singularize if self.sample_name
  end
  
  def smart_add_url_protocol
    if self.website
      unless self.website[/^http:\/\//] || self.website[/^https:\/\//]
        self.website = 'http://' + self.website
      end
    end
    if self.facebook
      unless self.facebook[/^http:\/\//] || self.facebook[/^https:\/\//]
        self.facebook = 'http://' + self.facebook
      end
    end
  end

  def check_configuration
    valid = true
    if self.description_type == nil or ["",nil].include? self.description_location
      valid = false
    end
    if self.name_type == nil or ["",nil].include? self.name_location
      valid = false
    end
    if self.price_type == nil or ["",nil].include? self.price_location
      valid = false
    end
    if self.product_number_type == nil or ["",nil].include? self.product_number_location
      valid = false
    end
    if self.website == nil 
      valid = false
    end
    self.scraping_configured = valid
  end
end
