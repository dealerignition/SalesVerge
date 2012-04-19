class SessionsController < ApplicationController
  skip_authorization_check
  layout "session"

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    @user = User.find_by_email(params[:email])
    if user
      flash[:notice] = "Welcome, #{@user.first_name}!"
      redirect_back_or_to dashboard_path
    else
      flash[:error] = "Email or password was invalid."
      render :new
    end
  end

  def destroy
    logout
    flash[:alert] = "Come back soon!"
    redirect_to login_path
  end

end
