class UsersController < ApplicationController
  load_and_authorize_resource
  layout "session"

  def new
    @user = User.new
    @user.email = @user.invitation.recipient_email if @user.invitation
    @invitation = Invitation.find_by_token(params[:invitation_token])
  end

  def create
    @user = User.new(params[:user])
    @user.role = "salesrep"
    if @user.save
      flash[:notice] = "Your account has been created! Your email address to log in is #{@user.email}."
      redirect_to login_path
    else
      flash[:error] = "There were some problems creating your account."
      redirect_to :back
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User was successfully updated."
      redirect_to :back
    else
      flash[:error] = "Account could not be updated."
      #NOTE this needs to be a render for the form errors to get passed through.
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
  
  def detatch_avatar
    @user = current_user
    @user.avatar = nil
    if @user.save
      flash[:notice] = "Avatar has been removed."
    end
    redirect_to account_settings_account_path
  end
  
end
