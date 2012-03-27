class AppointmentsController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  
  def index
    @appointments = Appointment.order("status DESC, date ASC").all
    @pending_appointments = Appointment.where("status NOT LIKE ? ", "Completed").count
  end
  
  def new
    @appointment = Appointment.new
    @customers = Customer.all
  end
  
  def create
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
      flash[:notice] = "Appointment was successfully created."
      redirect_to appointments_path
    else
      render 'new'
    end
  end
  
  def update
    @appointment = Appointment.find(params[:id])
    
    if @appointment.update_attributes(params[:appointment])
      flash[:notice] = "Appointment was successfully updated."
      redirect_to(appointments_path)
    else
      flash[:error] = "There was a problem updating the appointment."
      redirect_to(appointments_path)
    end
  end
  
end
