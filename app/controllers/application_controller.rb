class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery
  layout :setup_layout

  def confirm_active
    if !current_user.active?
      logout
      flash[:alert] = "Your account has been deactivated. See your account administrator for details."
      redirect_to login_url
    end
  end

  def require_owner
    if current_user.role != "owner"
      flash[:error] = "Only account owners can see that."
      redirect_to account_settings_account_path
    end
  end

  DATE_RANGES = {
    :today => "updated_at > TIMESTAMP 'today'",
    :yesterday => "TIMESTAMP 'today' > updated_at AND updated_at > TIMESTAMP 'yesterday'",
    :this_month => "updated_at > CURRENT_DATE - INTERVAL '#{Date.today.day} days'",
    :last_30_days =>  "updated_at > CURRENT_DATE - INTERVAL '30 days'",
    :all_time => "updated_at > TIMESTAMP '-infinity'"
  }

  private

  def not_authenticated
    flash[:error] = "You must login to see that page." unless request.path == "/"
    redirect_to login_url
  end

  rescue_from CanCan::AccessDenied do |exception|
    request.env["HTTP_REFERER"] ||= dashboard_path

    begin
      msg = exception.subject.class.model_name.downcase!
    rescue
      msg = "page"
    end

    redirect_to :back, :flash => { :error => "You do not have permission to see this #{msg}." }
  end

  def setup_layout
    if current_user && current_user.salesrep?
      "sales_rep"
    else
      "main"
    end
  end

end
