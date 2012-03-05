class SampleCheckoutsController < ApplicationController
  
  def index
    @checked_out_samples = SampleCheckout.all
  end
  
  def new
    @sample_checkout = SampleCheckout.new
    @samples = Sample.all
    @customers = Customer.all
  end
  
  def create
    @sample_checkout = SampleCheckout.new(params[:sample_checkout])
    if @sample_checkout.save
      redirect_to(sample_checkouts_path, :notice => 'Sample was successfully checked-out.')
    else
      render :action => "new"
    end
  end
  
end
