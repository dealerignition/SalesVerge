require 'spec_helper'

describe DealersController do

  describe "GET 'new'" do
    before do
      get :new
    end

    it do
      should respond_with :success
      should assign_to(:dealer).with_kind_of(Dealer)
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
          :dealer => {
            :name => "Awesome Dealer"
          },
          :user => owner_attributes
      end

      it do
        should redirect_to dashboard_path

        owner = User.find_by_email(@email)
        owner.owner?.should be_true
        dealer = Dealer.find_by_name("Awesome Dealer")
        owner.dealer.should == dealer
      end
    end
  end

end
