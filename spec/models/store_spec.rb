require 'spec_helper'

describe Store do
  it { should validate_presence_of :name }
  it { should belong_to :dealer }
end

describe Sample do
  it { should belong_to :store }
end

describe Dealer do
  it { should have_many :stores }
end
