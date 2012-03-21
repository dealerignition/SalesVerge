class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      flash[:notice] = "You are now logged in!"
      redirect_back_or_to root_url
    else
      flash[:alert] = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    flash[:notice] = "You have been logged out."
    redirect_to login_path
  end
end
