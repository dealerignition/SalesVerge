require 'spec_helper'

describe DealersController do

  describe "GET 'new'" do
    before do
      get :new
    end
    it { should respond_with :success }
    it { should assign_to(:dealer).with_kind_of(Dealer) }
    it { should assign_to(:user).with_kind_of(User) }
  end

  describe "POST 'create'" do
    pending
  end

end
