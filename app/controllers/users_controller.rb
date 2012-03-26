class UsersController < ApplicationController
  def new
    @user = User.new
    @dealers = Dealer.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_path
      flash[:notice] = "Signed up! You can now log in."
    else
      render :new
    end
  end
  
  def admin_create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User created!"
      redirect_to :back
    else
      flash[:error] = "There were errors creating your new user."
      redirect_to :back
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User was successfully updated."
      redirect_to :back
    else
      redirect_to :back
    end
  end
end
