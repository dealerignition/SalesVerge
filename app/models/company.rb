class Company < ActiveRecord::Base
  has_many :company_users, :dependent => :destroy
  has_many :users, :through => :company_users
  has_many :customers, :through => :users

  before_save :singularize_sample_name

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
end
