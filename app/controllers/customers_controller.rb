class CustomersController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active

  load_and_authorize_resource

  def index
    @customers = params[:query] ? search(params[:query]) :
      Customer.accessible_by(current_ability)

    respond_to do |format|
      format.html do
        render @customers, :layout => false if params[:query] and request.xhr?
      end
      format.json { render :json => @customers }
    end
  end

  def show
    @customer = Customer.find_by_id(params[:id])
    rapleaf = RapleafApi::Api.new('c7e2c4cbcb32f1bf6d86b20551d48186')
    # query_by_nap(first, last, street, city, state, options)
    @rapleaf_info = rapleaf.query_by_nap(
      @customer.first_name,
      @customer.last_name,
      @customer.address_1,
      @customer.city,
      @customer.state,
      :email => @customer.email,
      :show_availble => true )

    @timeline_stream = @customer.estimates + @customer.sample_checkouts
    @timeline_stream.sort! do |a,b|
      -(a.updated_at <=> b.updated_at)
    end
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    @customer.user = current_user

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

  private

  def search(query)
    @query = query.split().join("|")
    query_fields = [:first_name, :last_name, :email]

    @customers = Customer.accessible_by(current_ability)
                  .select(query_fields.push(:id))
                  .where("(#{query_fields.join("||")}) ~* ?", @query)

    query = Regexp.compile("(#{@query})", Regexp::IGNORECASE)
    @customers.sort_by! do |customer|
      count = 0
      query_fields.each do |field|
        count += 1 if customer.send(field) =~ query
      end
      puts customer.first_name, count

      -count
    end

    @customers
  end

end
