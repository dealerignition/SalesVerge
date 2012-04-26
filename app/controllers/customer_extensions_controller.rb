class CustomerExtensionsController < ApplicationController
  # Justin's trial RapLeaf API key:       c7e2c4cbcb32f1bf6d86b20551d48186
  # Steven's production RapLeaf API key:  22045e6e52abd5fd2ecaa0829be2217c
  # query_by_nap(first, last, street, city, state, options)
  
  def new
    @extension = CustomerExtension.new
  end
  
  def create
    @customer = Customer.find_by_id(params[:id])
    rapleaf = RapleafApi::Api.new('c7e2c4cbcb32f1bf6d86b20551d48186')
    begin
      @rapleaf_info = rapleaf.query_by_nap(
        @customer.first_name,
        @customer.last_name,
        @customer.address_1,
        @customer.city,
        @customer.state,
        :email => @customer.email,
        :show_availble => true )
    rescue
      @rapleaf_info = {}
    end
    @extension.customer_id          = @customer.id
    @extension.age                  = @rapleaf_info["age"]
    @extension.gender               = @rapleaf_info["gender"]
    @extension.marital_status       = @rapleaf_info["marital_status"]
    @extension.education            = @rapleaf_info["education"]
    @extension.household_income     = @rapleaf_info["household_income"]
    @extension.home_owner_status    = @rapleaf_info["home_owner_status"]
    @extension.home_market_value    = @rapleaf_info["home_market_value"]
    @extension.home_propery_value   = @rapleaf_info["home_property_value"]
    @extension.length_of_residence  = @rapleaf_info["length_of_residence"]
    @extension.zip                  = @rapleaf_info["zip"]
    @extension.occupation           = @rapleaf_info["occupation"]
    if @extension.save
      redirect_to @customer
    else
      redirect_to @customer
    end
  end
  
end
