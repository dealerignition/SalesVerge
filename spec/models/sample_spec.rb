require 'spec_helper'

describe Sample do
  before do
    FactoryGirl.create :sample
  end

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :dealer_sample_id }
end

=begin
describe Store do
  it { should have_many :samples }
end
=end
