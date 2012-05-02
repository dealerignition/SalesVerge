class UsersController < ApplicationController
  layout false
  load_and_authorize_resource

  def new
    @user = User.new
    @user.email = @user.invitation.recipient_email if @user.invitation
    @invitation = Invitation.find_by_token(params[:invitation_token])
    unless @invitation
      flash[:error] = "That invitation is not valid."
      redirect_to login_path
    end
  end

  def create_from_invitation
    @user = User.new(params[:user])
    @user.role = "salesrep"
    if @user.save
      flash[:notice] = "Yay"
      redirect_to login_path
    else
      flash[:notice] = "Awww"
    end
    redirect_to login_path
  end

  def create
    @user = User.new(params[:user])
    @user.role = "salesrep"
    @user.dealer = current_user.dealer
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
