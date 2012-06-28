class UserMailer < ActionMailer::Base
  layout "customer_mailer", :only => [:email_preview]
  include CanCan::Ability
  default from: "notifications@dealeronthego.com"
  
  DID_YOU_KNOW = [
    "You can see extended information about your customers by going into Extras inside your Settings and subscribing to the Extended customer information feature.",
    "You can invite co-workers to join your company under the Users section in your Settings.", 
    "You can have us pull in the latest products from your website by tapping the Website Product Grabber under your Company Info settings.",
    "You can upload your own avatar/photo in your Account Settings that will be used in email messages sent to your customers."
  ]

  def welcome_email(user)
    @user = user
    @url = login_path
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

  def connection_invitation(invitation)
    @invitation = invitation
    @url = invitation_connect_url(:invitation_token => @invitation.token)
    mail(:to => @invitation.recipient_email, :subject => 'Invitation')

    @invitation.update_attribute(:sent_at, Time.now)
  end

  def email_preview(user, company)
    @user = user
    @company = company
    render :layout => 'customer_mailer'
    mail(:to => @user.email, :subject => "Here is your preview")
  end

  def long_checkout_notification(sample_checkouts)
    sample_checkouts = [sample_checkouts, ] unless sample_checkouts.instance_of? Array
    @sample_checkouts = sample_checkouts
    @customer = sample_checkouts.first.customer
    @user = sample_checkouts.first.user
    @company = @user.company
    mail(:to => @user.email, :subject => "FYI, #{@customer.full_name} has had some #{@company.sample_name}(s) out for a while")
  end
  
  def app_request(app_request)
    @app_request = app_request
    mail(:to => @app_request.email, :subject => "Thank you for your interest in #{@app_request.app_name}")
  end
  
  def low_activity(user)
    @user = user
    r = Random.new
    @did_you_know = DID_YOU_KNOW[r.rand(0..3)]
    mail(:to => @user.email, :subject => "Getting started")
  end

end
