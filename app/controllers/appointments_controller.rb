class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.order("status DESC, date ASC").all
  end
  
  def new
    @appointment = Appointment.new
    @customers = Customer.all
  end
  
  def create
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
      redirect_to appointments_path
    else
      render 'new'
    end
  end
  
  def update
    @appointment = Appointment.find(params[:id])
    
    if @appointment.update_attributes(params[:appointment])
      redirect_to(appointments_path)
      flash[:notice] = "Theme was successfully updated."
    else
      redirect_to(appointments_path)
      flash[:error] = "There was a problem updating the Theme."
    end
  end
  
end
