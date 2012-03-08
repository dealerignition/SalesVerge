require 'spec_helper'

describe Quote do
  it { should have_many :charges }
  it { should belong_to :customer }

  context "money" do
    before do
      @q = FactoryGirl.create :quote
      FactoryGirl.create_list :charge, 25, :quote => @q
    end

    it "should total the charges" do
      @q.total.should == 37.5
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
