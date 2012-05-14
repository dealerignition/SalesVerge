class UsersController < ApplicationController
  load_and_authorize_resource
  layout "session"

  def new
    @user = User.new
    @user.email = @user.invitation.recipient_email if @user.invitation
    @invitation = Invitation.find_by_token(params[:invitation_token])
    redirect_to :signup unless @invitation
  end

  def create
    @user = User.new params[:user]
    @user.role = "user"

    @invitation = Invitation.find_by_token params[:invitation_token]
    redirect_to :signup unless @invitation

    if @user.save

      CompanyUser.create(
        :user => @user,
        :company => @invitation.sender.company,
        :role => :salesrep
      )

      auto_login(@user)
      remember_me!
      redirect_to :dashboard
    else
      render :new
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
      flash[:error] = "There was an error. Please try subscribing on the <a href=\"/settings/extras\">Account Settings > Extras</a> page.".html_safe
      redirect_to :back
    end
  end

  def detatch_avatar
    @user = current_user
    @user.avatar = nil
    if @user.save
      flash[:notice] = "Avatar has been removed."
    end
    redirect_to settings_account_path
  end

end
