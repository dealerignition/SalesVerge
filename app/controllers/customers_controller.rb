class CustomersController < ApplicationController
  require 'rapleaf_api'

  def index
    if params[:search]
      val = "%#{ params[:search] }%"
      @customers = Customer.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?",
                val, val, val)
    else
      @customers = Customer.all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @customers }
    end
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
      redirect_to @customer
      flash[:notice] = "Customer was successfully created."
    else
      flash[:error] = "Customer was not successfully created."
      render :action => "new"
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      redirect_to @customer
      flash[:notice] = "Customer was successfully updated."
    else
      redirect_to edit_customer_path(@customer)
      flash[:error] = "Update failed."
    end
  end
  
end
