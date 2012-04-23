class SampleCheckoutsController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource

  def new
    @sample_checkout = SampleCheckout.new
    @samples = Sample.accessible_by(current_ability)
    @customers = Customer.accessible_by(current_ability)
    @sample = Sample.new
    @store = current_user.dealer.stores.first
    @sample_name = current_user.dealer.sample_name
  end

  def create
    if params[:customer_id] && params[:sample_ids]
      @customer = Customer.find(params[:customer_id])
      sample_checkouts = []
      params[:sample_ids].split("|").each do |id|
        sample_checkouts.push(SampleCheckout.create :customer => @customer,
                                  :user => current_user,
                                  :sample => Sample.find(id),
                                  :checkout_time => Time.now
                              )
      end
      CustomerMailer.sample_checkout(sample_checkouts).deliver

      flash[:notice] = "#{current_user.dealer.sample_name.pluralize} were successfully checked-out. An email was sent to #{@customer.email}."
      redirect_to :back
    else
      @sample_checkout = SampleCheckout.new(params[:sample_checkout])

      if @sample_checkout.save
        CustomerMailer.sample_checkout(@sample_checkout).deliver
        flash[:notice] = "#{@sample_checkout.sample.name} was successfully checked-out. An email was sent to #{@sample_checkout.customer.email}."
        redirect_to sample_checkouts_path
      else
        flash[:error] = "Sample was not checked-out."
        render "new"
      end

    end
  end

  def update
    @sample_checkout = SampleCheckout.find(params[:id])

    if @sample_checkout.update_attributes(params[:sample_checkout])
      flash[:notice] = "#{@sample_checkout.sample.name} was successfully checked-in."
    else
      flash[:error] = "Sample was not updated."
    end

    redirect_to sample_checkouts_path
  end

  def check_in
    @sample_checkout = SampleCheckout.find(params[:sample_checkout_id])
    @sample_checkout.checkin_time = Time.now
    if @sample_checkout.save
      flash[:notice] = "Sample has been checked-in."
    else
      flash[:error] = "Sample has not been checked-in."
    end
    redirect_to :back
  end

end
