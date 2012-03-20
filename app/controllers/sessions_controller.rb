class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url
      flash[:notice] = "Logged in!"
    else
      flash[:alert] = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
    flash[:notice] = "Logged out!"
  end
end
