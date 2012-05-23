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
    @sample = Sample.new
    @note = Note.new

    @user = User.find_by_id(current_user.id)

    @timeline_stream = @customer.quotes.includes(:customer, :charges)
    @timeline_stream += @customer.sample_checkouts.includes(:customer, :sample)
    @timeline_stream += @customer.notes

    @timeline_stream.sort! { |a,b| -(a.updated_at <=> b.updated_at) }
    
    @email_stream = SentEmail.accessible_by(current_ability).order("created_at DESC")
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.user = current_user

    if @customer.save
      if current_user.subscribes_to_customer_extensions?
        CustomerExtension.create(:customer_id => @customer.id)
      else
      end
      redirect_to @customer
      flash[:notice] = "Customer was successfully created."
    else
      render 'new'
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Customer was successfully updated."
    else
      flash[:error] = "Customer could not be updated."
    end
    redirect_to @customer
  end

end
