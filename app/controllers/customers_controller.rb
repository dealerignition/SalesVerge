class CustomersController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource
  
  track :index, "visited the customer index page"
  track :show, "viewed a customer"
  track :new, "started a new customer"
  track :create, "created a new customer"
  track :update, "updated a customer"

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
    @timeline_stream.sort! { |a,b| -((a.is_a?(SampleCheckout) ? a.checktime : a.updated_at) <=> (b.is_a?(SampleCheckout) ? b.checktime : b.updated_at)) }
    if current_user.admin?
      @timeline_stream = @timeline_stream.paginate(:page => params[:page], :per_page => 30)
    end
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
    @customer.attributes = params[:customer]
    if @customer.save!
      flash[:notice] = "Customer was successfully updated."
    else
      flash[:error] = "Customer could not be updated."
    end
    redirect_to :back
  end

end
