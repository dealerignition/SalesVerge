require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    before do
      login_user FactoryGirl.create(:owner)

      @customers = FactoryGirl.create_list :customer, 5
      @samples = FactoryGirl.create_list :sample, 5

      get :index
    end
    it do
      should respond_with :success

      should assign_to(:customers)
      should assign_to(:checked_out_samples)
      should assign_to(:quotes)
    end
  end

end
