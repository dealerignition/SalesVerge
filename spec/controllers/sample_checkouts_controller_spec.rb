require 'spec_helper'

describe SampleCheckoutsController do

  describe "GET 'index'" do
    before do
      login_user FactoryGirl.create(:user)
      get :index
    end

    it { should respond_with :success }
    it { should assign_to(:checked_out_samples) }
  end

end
