class AppointmentsController < ApplicationController
  before_filter :require_login
  
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
      redirect_to appointments_path
      flash[:notice] = "Appointment was successfully created."
    else
      render 'new'
      flash[:error] = "Appointment was not created."
    end
  end
  
  def update
    @appointment = Appointment.find(params[:id])
    
    if @appointment.update_attributes(params[:appointment])
      redirect_to(appointments_path)
      flash[:notice] = "Appointment was successfully updated."
    else
      redirect_to(appointments_path)
      flash[:error] = "There was a problem updating the appointment."
    end
  end
  
end
