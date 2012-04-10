class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  # TODO: Change this when dashboard is finished.
  skip_authorization_check

  def index
    @customers = Customer.accessible_by(current_ability).order("created_at ASC").last(5)
    @late_appointments = Appointment.accessible_by(current_ability).where("date < ? AND status NOT LIKE ?", Date.today, "Completed").all
    @checked_out_samples = SampleCheckout.accessible_by(current_ability).find_all_by_checkin_time(nil)
    @estimates = Estimate.accessible_by(current_ability).order("created_at DESC").last(5)

    # For SalesRep view
    if current_user.salesrep?
      @new_customers = Customer.where("created_at > ?", Date.today.beginning_of_day).accessible_by(current_ability).count
      @new_checked_out_samples = SampleCheckout.where("created_at > ?", Date.today.beginning_of_day).accessible_by(current_ability).count
      @new_estimates = Estimate.where("created_at > ?", Date.today.beginning_of_day).accessible_by(current_ability).count
    end

    @timeline_stream = []
    Customer.accessible_by(current_ability).each do |customer|
      @timeline_stream += customer.estimates + customer.sample_checkouts
    end

    @timeline_stream.sort! do |a,b|
      -(a.updated_at <=> b.updated_at)
    end
  end

end
