class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find_by_id(params[:id])
  end
  
  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to(@customer, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end
  
end
