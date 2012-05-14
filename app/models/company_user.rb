class CompanyUser < ActiveRecord::Base
  ROLES = ["salesrep", "owner"]

  belongs_to :company
  belongs_to :user

  validates_presence_of :company_id
  validates_presence_of :user_id
  validates_presence_of :role

  validates_uniqueness_of :user_id, :for => :company_id

  # TODO Add scope for roles
end
