class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :confirm_active
  # TODO: Change this when dashboard is finished.
  skip_authorization_check

  track :index, "visited the dashboard"
  track :big_screen, "visited the big screen"
  
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
    @timeline_stream += SampleCheckoutSet.accessible_by(current_ability)
                          .includes(:customer, :sample_checkouts)
                          .where(@date_range_string.gsub("checkin_time", "sample_checkout_set.checkin_time"))
    @timeline_stream += Note.accessible_by(current_ability)
                          .includes(:customer)
                          .where(@date_range_string.gsub("updated_at", "notes.updated_at"))
    @timeline_stream.sort! { |a,b| -((a.is_a?(SampleCheckoutSet) ? a.checktime : a.updated_at) <=> (b.is_a?(SampleCheckoutSet) ? b.checktime : b.updated_at)) }
    if current_user.admin?
      @timeline_stream = @timeline_stream.paginate(:page => params[:page], :per_page => 30)
    end
    @email_stream = SentEmail.accessible_by(current_ability).order("created_at DESC")
 end

 def big_screen
   limiter = 12
   @customers = Customer.accessible_by(current_ability).order("created_at ASC").last(limiter)
   @checked_out_samples = SampleCheckout.accessible_by(current_ability).find_all_by_checkin_time(nil).last(limiter)
   @quotes = Quote.accessible_by(current_ability).order("created_at DESC").last(limiter)
   render :layout => 'big_screen'
 end

end
