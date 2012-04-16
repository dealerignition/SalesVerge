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

    @customers = Customer.accessible_by(current_ability).order("created_at ASC")

    @customers = @customers.where(@date_range_string) if current_user.salesrep?

    @late_appointments = Appointment.accessible_by(current_ability)
          .where("date < TIMESTAMP 'today' AND status NOT LIKE 'Completed'").all
    @checked_out_samples = SampleCheckout.accessible_by(current_ability).find_all_by_checkin_time(nil)
    @estimates = Estimate.accessible_by(current_ability).order("created_at DESC").last(5)

    @timeline_stream = @customers
    Customer.accessible_by(current_ability).each do |customer|
      [:estimates, :sample_checkouts, :notes].each do |field|
        @timeline_stream += customer.send(field).where(@date_range_string)
      end
    end
    
    @charge = Charge.new

    @timeline_stream.sort! { |a,b| -(a.updated_at <=> b.updated_at) }
 end

end
