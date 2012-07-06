class SampleCheckoutSetsController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  load_and_authorize_resource
  
  track :check_in, "checked a sample back in"
  
  def check_in
    @sample_checkout_set = SampleCheckoutSet.find(params[:sample_checkout_set_id])
    @sample_checkout_set.checkin_time = Time.now
    if @sample_checkout_set.save
      flash[:notice] = "#{current_user.company.sample_name} has been checked-in."
    else
      flash[:error] = "#{current_user.company.sample_name} has not been checked-in."
    end
    redirect_to :back
  end
  
end