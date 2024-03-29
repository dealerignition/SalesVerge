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
    respond_to do |format|
      format.html {
        searchable_index(Customer, [:first_name, :last_name, :email])
      }
      format.csv { 
        @customers = Customer.accessible_by(current_ability).all
        render text: @customers.export_to_csv
      }
    end
  end
  
  def getcsv
    @customers = Customer.accessible_by(current_ability).all
    csv_string = CSV.generate do |csv|
      csv << ['First Name', 'Last Name', 'Address 1', 'Address 2', 'City', 'State', 'Zip', 'Email', 'Phone']
      @customers.each do |c|
        csv << [c.first_name, c.last_name, c.address_1, c.address_2, c.city, c.state, c.zip, c.email, c.phone]
      end
    end
    send_data csv_string, :type => "text/plain",
   :filename => "customers.csv",
   :disposition => 'attachment'
  end

  def show
    @customer = Customer.find_by_id(params[:id])
    @charge = Charge.new
    @sample = Sample.new
    @note = Note.new
    @user = User.find_by_id(current_user.id)
    @timeline_stream = @customer.quotes.includes(:customer, :charges)
    @timeline_stream += SampleCheckoutSet.where(:customer_id => @customer.id).includes(:customer, :sample_checkouts)
    @timeline_stream += @customer.notes
    @timeline_stream.sort! { |a,b| -((a.is_a?(SampleCheckoutSet) ? a.checktime : a.updated_at) <=> (b.is_a?(SampleCheckoutSet) ? b.checktime : b.updated_at)) }
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
