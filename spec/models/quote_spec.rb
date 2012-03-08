require 'spec_helper'

describe Quote do
  it { should validate_presence_of :quote_type }
  it { 
    should allow_value("quote").for(:quote_type) 
    should allow_value("estimate").for(:quote_type) 
    should_not allow_value("baloney").for(:quote_type) 
    should_not allow_value("crud").for(:quote_type) 
  }
  it { should have_many :charges }

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

  it "should be printable" do
    pending
  end
end
