class AccountSettingsController < ApplicationController
  before_filter :require_login
  skip_authorization_check
  
  def account
    @user = current_user
  end
  
  def dealer
    @user = current_user
    @dealer = Dealer.find(@user.dealer_id)
  end
  
  def users
    @user = User.new
    @dealer = current_user.dealer
  end

end
