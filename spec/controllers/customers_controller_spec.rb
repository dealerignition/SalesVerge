require 'spec_helper'

describe CustomersController do

  describe "GET 'index'" do
    context "salesrep" do
      before do
        @user = FactoryGirl.create :salesrep
        login_user @user
        @customers = FactoryGirl.create_list :customer, 25, 
          :user => @user
        @others = FactoryGirl.create_list :customer, 25,
          :user => FactoryGirl.create(:salesrep)

        get :index
      end

      it { should assign_to(:customers).with(@customers) }
      it { should respond_with :success }
    end

    context "owner" do
      before do
        @user = FactoryGirl.create :owner
        login_user @user
        @customers = FactoryGirl.create_list :customer, 25, 
          :user => FactoryGirl.create(:salesrep, :dealer => @user.dealer)
        @others = FactoryGirl.create_list :customer, 25,
          :user => FactoryGirl.create(:salesrep, :dealer => @user.dealer)

        @all = @customers + @others

        get :index
      end

      it do
        should respond_with :success
        should assign_to(:customers).with(@all)
      end
    end

  end

  describe "GET '/:customerid'" do
    before do
      @user = FactoryGirl.create(:salesrep)
      login_user @user
      @customer = FactoryGirl.create :customer, :user => @user
      get :show, :id => @customer.id
    end

    it do
      should respond_with :success
      should assign_to(:customer).with(@customer)
    end

  end

  describe "GET '/new'" do
    before do
      login_user FactoryGirl.create(:salesrep)
      get :new
    end

    it { should respond_with :success }
    it { should assign_to(:customer).with_kind_of(Customer) }

  end

  describe "GET '/create'" do
    context "valid data" do
      before do
        @user = FactoryGirl.create(:salesrep)
        login_user @user

        post :create,
          :customer => FactoryGirl.attributes_for(:customer)
      end

      it do
        @customer = Customer.all.last
        @customer.user.should == @user
        should redirect_to customer_path(@customer.id)
      end
    end
  end

end
