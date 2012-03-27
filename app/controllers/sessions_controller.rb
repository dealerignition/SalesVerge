class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    @user = User.find_by_email(params[:email])
    if user
      flash[:notice] = "You are now logged in!"
      redirect_back_or_to dashboard_path
    else
      flash[:error] = "Email or password was invalid."
      render :new
    end
  end

  def destroy
    logout
    flash[:alert] = "You have been logged out."
    redirect_to login_path
  end
  
end
