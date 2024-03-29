require 'spec_helper'

describe Customer do
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :user_id }
  it { should have_many :quotes }
  it { should belong_to :user }
end
