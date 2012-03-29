class SampleCheckoutsController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  
  def index
    @checked_out_samples = SampleCheckout.find_all_by_checkin_time(nil)
  end
  
  def new
    @sample_checkout = SampleCheckout.new
    @samples = Sample.all
    @customers = Customer.all
    @sample = Sample.new
  end
  
  def create
    @sample_checkout = SampleCheckout.new(params[:sample_checkout])
    if @sample_checkout.save
      CustomerMailer.sample_checkout(@sample_checkout).deliver
      flash[:notice] = "Sample was successfully checked-out. An email was sent to #{@sample_checkout.customer.email}."
      redirect_to sample_checkouts_path
    else
      flash[:error] = "Sample was not checked-out."
      render "new"
    end
  end
  
  def edit
    @sample_checkout = SampleCheckout.find(params[:id])
  end
  
  def update
    @sample_checkout = SampleCheckout.find(params[:id])
    if @sample_checkout.update_attributes(params[:sample_checkout])
      redirect_to sample_checkouts_path
      flash[:notice] = "Sample was successfully updated."
    else
      redirect_to sample_checkouts_path
      flash[:error] = "Sample was not updated."
    end
  end
  
end
