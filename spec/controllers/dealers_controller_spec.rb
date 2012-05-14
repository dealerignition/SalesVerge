require 'spec_helper'

describe CompanysController do

  describe "GET 'new'" do
    before do
      get :new
    end

    it do
      should respond_with :success
      should assign_to(:company).with_kind_of(Company)
      should assign_to(:user).with_kind_of(User)
    end
  end

  describe "POST 'create'" do
    context "valid data" do
      before do
        owner_attributes = FactoryGirl.attributes_for :owner
        owner_attributes.delete(:role)
        @email = owner_attributes[:email]

        post :create,
          :company => {
            :name => "Awesome Company"
          },
          :user => owner_attributes
      end

      it do
        should redirect_to dashboard_path

        owner = User.find_by_email(@email)
        owner.owner?.should be_true
        company = Company.find_by_name("Awesome Dealer")
        owner.company.should == dealer
      end
    end
  end

end
