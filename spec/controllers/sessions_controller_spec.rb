require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    before do
      get :new
    end

    it { should respond_with :success }
  end

  describe "POST 'create' should login and redirect to root with valid credentials" do
    before do
      @user = Factory.create :user
      post :create, {
        :email => @user.email,
        :password => "test"
      }
    end

    it { should redirect_to root_url }
    it { controller.should be_logged_in }
    it { should set_the_flash }
  end

  describe "POST 'create' should not login with invalid credentials" do
    before do
      @user = Factory.create :user, :password => "test"
      post :create, {
        :email => @user.email,
        :password => "thisisnotmypassword"
      }
    end

    it { should render_template :new }
    it { controller.should_not be_logged_in }
    it { should set_the_flash }
  end

  describe "GET 'destroy' should delete the current session" do
    before do
      get :destroy
    end

    it { controller.should_not be_logged_in }
    it { should set_the_flash }
    it { should redirect_to login_path }
  end
end
