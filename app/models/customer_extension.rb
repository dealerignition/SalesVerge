class CustomerExtension < ActiveRecord::Base
  
  API_KEY =
    if Rails.env.development?
      # Justin's trial RapLeaf API key:
      "c7e2c4cbcb32f1bf6d86b20551d48186"
    else
      # Steven's production RapLeaf API key:
      "22045e6e52abd5fd2ecaa0829be2217c"
    end
  
  belongs_to :customer
  after_create :retrieve_data
  validates_uniqueness_of :customer_id
  
  def retrieve_data
    @customer = Customer.find_by_id(self.customer_id)
    begin
      # query_by_nap(first, last, street, city, state, options)
      @rapleaf_info = RapleafApi::Api.new(API_KEY).query_by_nap( 
        @customer.first_name, 
        @customer.last_name, 
        @customer.address_1, 
        @customer.city, 
        @customer.state, 
        :email => @customer.email )
      self.age                  = @rapleaf_info["age"]
      self.gender               = @rapleaf_info["gender"]
      self.marital_status       = @rapleaf_info["marital_status"]
      self.education            = @rapleaf_info["education"]
      self.household_income     = @rapleaf_info["household_income"]
      self.home_owner_status    = @rapleaf_info["home_owner_status"]
      self.home_market_value    = @rapleaf_info["home_market_value"]
      self.home_property_value  = @rapleaf_info["home_property_value"]
      self.length_of_residence  = @rapleaf_info["length_of_residence"]
      self.zip                  = @rapleaf_info["zip"]
      self.occupation           = @rapleaf_info["occupation"]
      self.save
    rescue
      unless Rails.env == "development"
        @rapleaf_info = {}
      end
    end
  end
  
end
