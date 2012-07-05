class SessionsController < ApplicationController
  skip_authorization_check
  layout "session"
  
  track :create, "logged in"

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    @user = User.find_by_email(params[:email])
    if user
      @user.increase_sign_in_count_and_update_last_sign_in
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
  
  def login_as
    if !current_user.admin?
      flash[:alert] = 'You must be an admin to do that'
    else
      if user = User.find_by_email(params[:email])
        auto_login(user)
        flash[:notice] = "Logged in as #{params[:email]}"
      else
        flash[:alert] = "No such user"
      end
    end
    redirect_to dashboard_path
  end

end
