require 'spec_helper'

describe QuotesController do

  describe "GET 'index'" do
    before do
      login_user FactoryGirl.create(:salesrep)

      get :index
    end

    it do
      should respond_with :success
    end
  end

  describe "GET 'new'" do
    before do
      login_user FactoryGirl.create(:salesrep)
      FactoryGirl.create_list :customer, 5

      get :new
    end

    it do
      should respond_with :success
      should assign_to :quote
      should assign_to :customers
    end
  end

  describe "GET 'edit'" do
    before do
      @user = FactoryGirl.create(:salesrep)
      login_user @user
      @quote = FactoryGirl.create :quote,
        :user => @user

      get :edit, :id => @quote.id
    end

    it do
      should respond_with :success
      should assign_to(:quote).with(@quote)
    end
  end
end
