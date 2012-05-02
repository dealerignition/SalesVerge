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
  
  def update_user_and_look_up_customer
    @user = User.find(params[:current_user_id])
    @customer = Customer.find_by_id(params[:customer_id])
    @customer_extension = CustomerExtension.new(:customer_id => @customer.id)
    if @customer_extension.save and @user.update_attributes(params[:user])
      flash[:notice] = "Thanks for subscribing!"
      redirect_to :back
    else
      flash[:error] = "There was an error. Please try subscribing on the <a href=\"/account_settings/extras\">Account Settings > Extras</a> page.".html_safe
      redirect_to :back
    end
  end
  
end
