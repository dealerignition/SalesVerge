class ChargesController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource

  def new
    @estimate = Estimate.find(params[:estimate_id])
    @charge = Charge.new
  end
  
  def create
    @charge = Charge.new(params[:charge], :date => Time.now)

    if @charge.save
      flash[:notice] = "Charge was successfully created."
    else
      flash[:error] = "Charge was not successfully created. Please try again."
    end

    redirect_to :back
  end

  def edit
    @charge = Charge.find(params[:id])
  end
  
  def destroy
    @charge = Charge.find(params[:id])
    @estimate = Estimate.find(params[:estimate_id])
    @charge.destroy

    flash[:notice] = "Charge deleted."
    redirect_to :back
  end

end
