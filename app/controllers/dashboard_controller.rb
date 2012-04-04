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
  end
  
end
