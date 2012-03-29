class UserMailer < ActionMailer::Base
  default from: "support@dealerignition.com"
  
  def welcome_email(user)
      @user = user
      @url  = "http://floorstoreonthego.com"
      mail(:to => @user.email, :subject => "Welcome to DealerOnTheGo")
  end
  
  def daily_digest(user)
    @user      = user
    @samples   = SampleCheckout.where("created_at > ?", 1.day.ago).all
    @estimates = Quote.where("created_at > ?", 1.day.ago).all
    @url       = login_path
    mail(:to => @user.email, :subject => "Your daily digest")
  end
  
end
