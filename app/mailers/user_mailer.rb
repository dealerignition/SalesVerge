class UserMailer < ActionMailer::Base
  layout "customer_mailer", :only => [:email_preview]
  include CanCan::Ability
  default from: "notifications@dealerbookapp.com"

  def welcome_email(user)
    @user = user
    @url  = "http://floorstoreonthego.com"
    mail(:to => @user.email, :subject => "Welcome to DealerOnTheGo")
  end

  def daily_digest(user)
    @user      = user
    current_ability = Ability.new(@user)
    @samples   = SampleCheckout.accessible_by(current_ability).where("sample_checkouts.created_at > ?", 1.day.ago).all
    @quotes = Quote.accessible_by(current_ability).where("quotes.created_at > ?", 1.day.ago).all
    @url       = login_path
    mail(:to => @user.email, :subject => "Your daily digest")
  end

  def invitation(invitation)
    @invitation = invitation
    @token = invitation.token
    @signup_url = new_user_url(:invitation_token => @token)
    mail(:to => @invitation.recipient_email, :subject => 'Invitation')

    @invitation.update_attribute(:sent_at, Time.now)
  end

  def email_preview(user, company)
    @user = user
    @company = company
    render :layout => 'customer_mailer'
    mail(:to => @user.email, :subject => "Here is your preview")
  end
end
