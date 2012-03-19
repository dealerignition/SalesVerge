class ApplicationController < ActionController::Base
  layout "main"

  protect_from_forgery
  
  private
  
  def not_authenticated
    redirect_to login_url
    flash[:error] = "You must login to access this page."
  end
end
