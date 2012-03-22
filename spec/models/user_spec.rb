require 'spec_helper'

describe User do
  it { should have_many :customers }
  it { should validate_presence_of :role }
  it do 
    ["owner", "admin", "salesrep"].each do |i|
      should allow_value(i).for(:role) 
    end

    ["asdfasdf", "this is a joke", "sales rep"].each do |i|
      should_not allow_value(i).for(:role) 
    end
  end

  context do
    before do
      @owner = FactoryGirl.create :owner
      @admin = FactoryGirl.create :admin
      @salesrep = FactoryGirl.create :salesrep
    end

    context "should have an admin? method" do
      it { @admin.admin?.should be_true }
      it { @owner.admin?.should be_false }
      it { @salesrep.admin?.should be_false }
    end

    context "should have an owner? method" do
      it { @admin.owner?.should be_false }
      it { @owner.owner?.should be_true }
      it { @salesrep.owner?.should be_false }
    end

    context "should have a salesrep? method" do
      it { @admin.salesrep?.should be_false }
      it { @owner.salesrep?.should be_false }
      it { @salesrep.salesrep?.should be_true }
    end
  end
end
