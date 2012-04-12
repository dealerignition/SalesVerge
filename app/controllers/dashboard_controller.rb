class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  # TODO: Change this when dashboard is finished.
  skip_authorization_check

  def index

    dates = {
      :today => "> TIMESTAMP 'today'",
      :yesterday => "> TIMESTAMP 'yesterday' AND updated_at < TIMESTAMP 'today'",
      :this_month => " > CURRENT_DATE - INTERVAL '1 month'",
      :all_time => "> TIMESTAMP '-infinity'"
    }

    @date_options = dates.keys
    @date_range = params[:date_range].to_s.to_sym
    date_query = "updated_at #{dates[@date_range] || dates[:all_time]}"

    @customers = Customer.accessible_by(current_ability)
                        .order("created_at ASC")
                        .where(date_query)
    @late_appointments = Appointment.accessible_by(current_ability)
                        .where("date < ? AND status NOT LIKE ?", Date.today, "Completed")
                        .all
    @checked_out_samples = SampleCheckout.accessible_by(current_ability)
                        .find_all_by_checkin_time(nil)
    @estimates = Estimate.accessible_by(current_ability)
                        .order("created_at DESC")
                        .last(5)

    @timeline_stream = @customers
    Customer.accessible_by(current_ability).each do |customer|
      [:estimates, :sample_checkouts, :notes].each do |field|
        @timeline_stream += customer.send(field)
                              .where(date_query)
      end
    end

    @timeline_stream.sort! do |a,b|
      -(a.updated_at <=> b.updated_at)
    end
  end

end
