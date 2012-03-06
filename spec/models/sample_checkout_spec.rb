require 'spec_helper'

describe SampleCheckout do
  it { should belong_to :customer }
  it { should belong_to :sample }
  it { should validate_presence_of :checkout_time }
end

describe Customer do
  it { should have_many :sample_checkouts }
end

describe Sample do
  it { should have_many :sample_checkouts }
end
