class CustomersController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active

  load_and_authorize_resource

  def index
    searchable_index(Customer, [:first_name, :last_name, :email])
  end

  def show
    @customer = Customer.find_by_id(params[:id])
    @charge = Charge.new
    @sample_checkout = SampleCheckout.new
    @sample = Sample.new
    @store = current_user.dealer.stores.first
    @note = Note.new

    @timeline_stream = @customer.quotes.includes(:customer, :charges)
    @timeline_stream += @customer.sample_checkouts.includes(:customer, :sample)
    @timeline_stream += @customer.notes

    @timeline_stream.sort! { |a,b| -(a.updated_at <=> b.updated_at) }
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.user = current_user

    if @customer.save
      CustomerExtension.create(:customer_id => @customer.id)
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
