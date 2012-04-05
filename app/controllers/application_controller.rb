class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery
  layout :setup_layout
  
  def confirm_active
    @user = current_user if current_user
    if !@user.active?
      logout
      flash[:alert] = "Your account has been deactivated. See your account administrator for details."
      redirect_to login_url
    end
  end
  
  private
  
  def not_authenticated
    redirect_to login_url
    flash[:error] = "You must login to access this page."
  end

  rescue_from CanCan::AccessDenied do |exception|
    request.env["HTTP_REFERER"] ||= dashboard_path
    begin
      msg = exception.subject.class.model_name.downcase! 
    rescue
      msg = "page"
    end

    redirect_to :back, :flash => { :error => "You are not authorized to access this #{msg}." }
  end
  
  def setup_layout
    return "main" unless current_user
    current_user.salesrep? ? "sales_rep" : "main"
  end
end
