class SampleCheckoutsController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource

  track :create, "checked out a sample"
  track :check_in, "checked a sample back in"
  
  def create
    @customer = Customer.find(params[:customer_id])
    @sample_checkout_set = SampleCheckoutSet.create(:customer_id => @customer.id, :user_id => current_user.id)
    sample_checkouts = []
    params[:sample_ids].split("|").each do |id|
      sample_checkouts.push(SampleCheckout.create :customer => @customer,
                                                  :user => current_user,
                                                  :sample => Sample.find(id),
                                                  :checkout_time => Time.now,
                                                  :sample_checkout_set_id => @sample_checkout_set.id)
    end
    sample_checkout_set = @sample_checkout_set
    CustomerMailer.sample_checkout(sample_checkout_set).deliver
    flash[:notice] = "#{current_user.company.sample_name}(s) were successfully checked-out. An email was sent to #{@customer.email}."
    redirect_to :back
  end

  def check_in
    @sample_checkout = SampleCheckout.find(params[:sample_checkout_id])
    @sample_checkout.checkin_time = Time.now
    if @sample_checkout.save
      flash[:notice] = "#{current_user.company.sample_name} has been checked-in."
    else
      flash[:error] = "#{current_user.company.sample_name} has not been checked-in."
    end
    redirect_to :back
  end

end
