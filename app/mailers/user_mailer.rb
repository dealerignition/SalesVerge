class UserMailer < ActionMailer::Base
  include CanCan::Ability
  default from: "support@dealerignition.com"
  
  def welcome_email(user)
      @user = user
      @url  = "http://floorstoreonthego.com"
      mail(:to => @user.email, :subject => "Welcome to DealerOnTheGo")
  end
  
  def daily_digest(user)
    @user      = user
    current_ability = Ability.new(@user)
    @samples   = SampleCheckout.accessible_by(current_ability).where("sample_checkouts.created_at > ?", 1.day.ago).all
    @estimates = Quote.accessible_by(current_ability).where("quotes.created_at > ?", 1.day.ago).all
    @url       = login_path
    mail(:to => @user.email, :subject => "Your daily digest")
  end
  
end
