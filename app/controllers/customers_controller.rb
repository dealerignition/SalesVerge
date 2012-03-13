class CustomersController < ApplicationController

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
    @customer = Customer.find params[:id]
  end
  
  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to(@customer, :notice => 'Customer was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      redirect_to(@customer, :notice => 'Customer was successfully created.')
    else
      redirect_to edit_customer_path(@customer)
    end
  end
  
end
