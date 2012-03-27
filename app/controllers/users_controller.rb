class UsersController < ApplicationController
  def create
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
