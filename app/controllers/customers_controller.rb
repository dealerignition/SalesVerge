class CustomersController < ApplicationController
  
  require 'rapleaf_api'
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find_by_id(params[:id])
    @api = RapleafApi::Api.new('c7e2c4cbcb32f1bf6d86b20551d48186')
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
