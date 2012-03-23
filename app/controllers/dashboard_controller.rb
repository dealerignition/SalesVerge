class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  
  def index
    @customers = Customer.order("created_at ASC").last(5)
    @late_appointments = Appointment.where("date < ? AND status NOT LIKE ?", Date.today, "Completed").all
    @checked_out_samples = SampleCheckout.find_all_by_checkin_time(nil)
    @quotes = Quote.order("created_at DESC").last(5)
  end
end
