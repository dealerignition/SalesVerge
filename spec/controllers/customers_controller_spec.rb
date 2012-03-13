require 'spec_helper'

describe CustomersController do

  describe "GET 'index'" do
    before do
      @customers = FactoryGirl.create_list :customer, 25
      get :index
    end

    it { should respond_with :success }
    it { should assign_to(:customers).with(@customers) }

  end

  describe "GET '/:customerid'" do
    before do
      @customer = FactoryGirl.create :customer
      get :show, :id => @customer.id
    end

    it { should respond_with :success }
    it { should assign_to(:customer).with(@customer) }

  end

  describe "GET '/new'" do
    before do
      get :new
    end

    it { should respond_with :success }
    it { should assign_to(:customer).with_kind_of(Customer) }

  end

  describe "GET '/create'" do
    pending
  end
end
