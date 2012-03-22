require 'spec_helper'

describe QuotesController do

  describe "GET 'index'" do
    it "returns http success" do
      login_user FactoryGirl.create(:user)
      get 'index'
      response.should be_success
    end
  end

end
