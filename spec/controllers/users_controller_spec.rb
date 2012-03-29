require 'spec_helper'

describe UsersController do
  describe "GET /new" do
    before do
      get :new
    end

    it do
      should respond_with :success
      should assign_to(:user).with_kind_of(User)
    end
  end

  describe "POST users/create" do
    context "with valid data" do
      before do
        login_user FactoryGirl.create(:owner)
        data = FactoryGirl.attributes_for(:salesrep)
        data = data.delete_if { |key| key == :role }
        @email = data[:email]

        post :create, :user => data
      end

      it do 
        should respond_with :success
        should respond_with_content_type :json
        should render_template("users/_user")
        should render_template("users/_form")

        user = User.find_by_email(@email)
        user.should_not be_nil
      end
    end

    context "with invalid data" do
      before do
        login_user FactoryGirl.create(:owner)
        post :create
      end

      it do
        should respond_with :success
        should assign_to(:user).with_kind_of(User)
        should respond_with_content_type :json
        should render_template("users/_form")
      end
    end
  end
end
