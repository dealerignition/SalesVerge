class SettingsController < ApplicationController
  before_filter :require_login
  before_filter :require_owner, :except => ['account', 'extras']
  
  skip_authorization_check
  
  def account
    @user = current_user
  end
  
  def password
    @user = current_user
  end
  
  def dealer
    @user = current_user
    @dealer = current_user.dealer
  end
  
  def general
    @user = current_user
    @dealer = current_user.dealer
  end
  
  def users
    @user = current_user
    @dealer = current_user.dealer
    @sent_invitations = @user.sent_invitations
  end
  
  def extras
    @user = current_user
  end
  
  def send_email_preview
    @user = current_user
    @dealer = current_user.dealer
    UserMailer.email_preview(@user, @dealer).deliver
    flash[:notice] = "Check your email for the preview."
    redirect_to :back
  end
  
  def email_preview_source
    @user = current_user
    @dealer = current_user.dealer
    render :layout => false
  end

end
