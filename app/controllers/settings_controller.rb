class SettingsController < ApplicationController
  before_filter :require_login
  before_filter :require_owner, :only => [:general, :users]

  skip_authorization_check
  
  track :account, "visited account settings"
  track :password, "visited password settings"
  track :company, "visited company settings"
  track :general, "visited general settings"
  track :users, "visited users"
  track :extras, "visited extras"
  track :send_email_preview, "sent an email preview"
  track :scraper_help

  def account
    @user = current_user
  end

  def password
    @user = current_user
  end

  def company
    @user = current_user
    @company = @user.company
  end

  def general
    @user = current_user
    @company = Company.find(@user.company.id)
  end

  def users
    @user = current_user
    @company = @user.company
    @invitation = Invitation.new
    @sent_invitations = @user.sent_invitations
      .where("status = 'sent' OR status = 'rejected'")
  end

  def extras
    @user = current_user
  end

  def send_email_preview
    @user = current_user
    @company = @user.company
    UserMailer.email_preview(@user, @company).deliver
    flash[:notice] = "Check your email for the preview."
    redirect_to :back
  end

  def scraper_help
    @user = current_user
    @company = @user.company
  end

end
