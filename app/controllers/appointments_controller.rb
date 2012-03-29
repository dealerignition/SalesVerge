class AppointmentsController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource
  
  def index
    @appointments = Appointment.accessible_by(current_ability).order("status DESC, date ASC").all
    @pending_appointments = Appointment.accessible_by(current_ability).where("status NOT LIKE ? ", "Completed").count
  end
  
  def new
    @appointment = Appointment.new
    @customers = Customer.accessible_by(current_ability)
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
    else
      flash[:error] = "There was a problem updating the appointment."
    end

    redirect_to(appointments_path)
  end
  
end
