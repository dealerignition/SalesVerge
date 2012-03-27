class CustomersController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  
  def index
    if params[:search]
      val = "%#{ params[:search] }%"
      @customers = Customer.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", val, val, val)
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
    rapleaf = RapleafApi::Api.new('c7e2c4cbcb32f1bf6d86b20551d48186')
    @rapleaf_info = rapleaf.query_by_email(@customer.email) unless Rails.env.eql? "test"
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
    end
  end
  
end
