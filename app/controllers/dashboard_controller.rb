class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  # TODO: Change this when dashboard is finished.
  skip_authorization_check

  def index
    @date_options = DATE_RANGES.keys
    @date_range = params[:date_range].to_s.to_sym
    @date_range = :all_time unless @date_range.in? @date_options
    @date_range_string = DATE_RANGES[@date_range]

    @timeline_stream = Customer.accessible_by(current_ability)
                          .where("customers." << @date_range_string)
    @timeline_stream += Quote.accessible_by(current_ability)
                          .includes(:customer, :charges)
                          .where("quotes." << @date_range_string)
    @timeline_stream += SampleCheckout.accessible_by(current_ability)
                          .includes(:customer, :sample)
                          .where("sample_checkouts." << @date_range_string)
    @timeline_stream += Note.accessible_by(current_ability)
                          .includes(:customer)
                          .where("notes." << @date_range_string)

    @timeline_stream.sort! { |a,b| -(a.updated_at <=> b.updated_at) }
 end

 def big_screen
   @customers = Customer.accessible_by(current_ability).order("created_at ASC")
   @late_appointments = Appointment.accessible_by(current_ability).where("date < TIMESTAMP 'today' AND status NOT LIKE 'Completed'").all
   @checked_out_samples = SampleCheckout.accessible_by(current_ability).find_all_by_checkin_time(nil)
   @quotes = Quote.accessible_by(current_ability).order("created_at DESC").last(5)
 end

end
