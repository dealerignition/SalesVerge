require 'spec_helper'

describe QuotesController do

  describe "GET 'show'" do
    before do
      @user = FactoryGirl.create(:salesrep)
      login_user @user
      @quote = FactoryGirl.create :quote,
        :user => @user

      get :show, :id => @quote.id
    end

    it do
      should respond_with :success
      should assign_to(:quote).with(@quote)
    end
  end
end
