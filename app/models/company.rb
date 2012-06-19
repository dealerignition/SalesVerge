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
    :s3_credentials => "config/aws.yml",
    :path => "/:style/:id/:filename"

  def singularize_sample_name
    self.sample_name = sample_name.singularize if self.sample_name
  end
  
  def smart_add_url_protocol
    if self.website.present?
      unless self.website[/^http:\/\/[a-z]+\./] || self.website[/^https:\/\/[a-z]+\./]
        self.website = 'http://www.' + self.website
      end
    end
    if self.facebook.present?
      unless self.facebook[/^http:\/\//] || self.facebook[/^https:\/\//]
        self.facebook = 'http://' + self.facebook
      end
    end
  end

  def check_configuration
    valid = true
    if self.description_type == nil or self.description_location.blank?
      valid = false
    end
    if self.name_type == nil or self.name_location.blank?
      valid = false
    end
    if self.price_type == nil or self.price_location.blank?
      valid = false
    end
    if self.product_number_type == nil or self.product_number_location.blank?
      valid = false
    end
    if self.website.blank?
      valid = false
    end
    self.scraping_configured = valid
    true
  end
end
