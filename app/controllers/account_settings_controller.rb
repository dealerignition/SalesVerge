class AccountSettingsController < ApplicationController
  before_filter :require_login
  before_filter :require_owner, :except => ['account', 'extras']
  
  skip_authorization_check
  
  def account
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

end
