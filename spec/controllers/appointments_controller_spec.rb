require 'spec_helper'

describe AppointmentsController do

  describe "GET 'index'" do
    before do
      login_user FactoryGirl.create(:user)
      FactoryGirl.create_list :appointment, 25
      @appointments = Appointment.order("status DESC, date ASC").all
      get :index
    end

    it { should respond_with :success }
    it { should assign_to(:appointments).with(@appointments) }
  end

  describe "GET '/new'" do
    before do
      login_user FactoryGirl.create(:user)
      @customers = FactoryGirl.create_list :customer, 25
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
