require 'spec_helper'

describe Charge do
  it { should validate_presence_of :date }
  it { should validate_presence_of :description }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :price }
  it { should belong_to :quote }

  it "should calculate the total" do
    @c = FactoryGirl.build :charge
    @c.total.should eq 1.5

    @c = FactoryGirl.build :charge2at1dot5
    @c.total.should eq 3.0

    @c = FactoryGirl.build :charge3at1dot2
    @c.total.should eq 3.6
  end
end
