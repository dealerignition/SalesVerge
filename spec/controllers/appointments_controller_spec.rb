require 'spec_helper'

describe AppointmentsController do

  describe "GET 'index'" do
    before do
      @user = FactoryGirl.create(:user)
      login_user @user
      FactoryGirl.create_list :appointment, 5,
        :user => @user
      @appointments = Appointment.order("status DESC, date ASC")
      get :index
    end

    it { should respond_with :success }
    it { should assign_to(:appointments).with(@appointments) }
  end

  describe "GET '/new'" do
    before do
      @user = FactoryGirl.create(:user)
      login_user @user
      @customers = FactoryGirl.create_list :customer, 5,
        :user => @user
      get :new
    end

    it { should respond_with :success }
    it { should assign_to(:appointment).with_kind_of(Appointment) }
    it { should assign_to(:customers).with(@customers) }

  end

  describe "PUT '/update'" do
    pending
  end
end
