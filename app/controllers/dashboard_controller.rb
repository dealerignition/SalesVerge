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
                          .where(@date_range_string.gsub("updated_at", "customers.updated_at"))
    @timeline_stream += Quote.accessible_by(current_ability)
                          .includes(:customer, :charges)
                          .where(@date_range_string.gsub("updated_at", "quotes.updated_at"))
    @timeline_stream += SampleCheckout.accessible_by(current_ability)
                          .includes(:customer, :sample)
                          .where(@date_range_string.gsub("updated_at", "sample_checkouts.updated_at"))
    @timeline_stream += Note.accessible_by(current_ability)
                          .includes(:customer)
                          .where(@date_range_string.gsub("updated_at", "notes.updated_at"))

    @timeline_stream.sort! { |a,b| -(a.updated_at <=> b.updated_at) }
 end

 def big_screen
   limiter = 12
   @customers = Customer.accessible_by(current_ability).order("created_at ASC").last(limiter)
   @checked_out_samples = SampleCheckout.accessible_by(current_ability).find_all_by_checkin_time(nil).last(limiter)
   @quotes = Quote.accessible_by(current_ability).order("created_at DESC").last(limiter)
   render :layout => 'big_screen'
 end

end
