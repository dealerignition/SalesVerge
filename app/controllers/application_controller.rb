class ApplicationController < ActionController::Base
  layout "main"

  protect_from_forgery
  
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
end
