class AccountSettingsController < ApplicationController
  before_filter :require_login
  before_filter :require_owner, :except => "account"
  
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
    @user = User.new
    @dealer = current_user.dealer
  end

end
