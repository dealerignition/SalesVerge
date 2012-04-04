require 'spec_helper'

describe Estimate do
  it { should have_many :charges }
  it { should belong_to :customer }

  context "money" do
    before do
      @e = FactoryGirl.create :estimate
      FactoryGirl.create_list :charge, 25, :estimate => @e
    end

    it "should total the charges" do
      @e.total.should == 37.5
    end
  end

  context "emails" do
    it "should be sent to the customer" do
      pending
    end

    it "should be sent to the dealer" do
      pending
    end
  end
end
