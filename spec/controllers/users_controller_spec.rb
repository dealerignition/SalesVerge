require 'spec_helper'

describe UsersController do

  describe "GET 'new' should render an empty User form" do
    before do
      get :create
    end

    it { should respond_with :missing }
  end

end
