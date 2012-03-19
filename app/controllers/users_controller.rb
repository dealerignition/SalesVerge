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
      flash[:error] = "There were some errors"
    end
  end
end
