class CompanyUser < ActiveRecord::Base
  ROLES = %w(salesrep owner)

  before_validation :downcase_role

  belongs_to :company
  belongs_to :user

  validates_presence_of :company_id
  validates_presence_of :user_id
  validates_presence_of :role

  validates_uniqueness_of :user_id, :for => :company_id
  validates_inclusion_of :role, :in => ROLES

  # TODO Add scope for roles

  def downcase_role
    self.role.downcase!
  end
end
