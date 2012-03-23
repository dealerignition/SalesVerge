class UserMailer < ActionMailer::Base
  default from: "support@dealerignition.com"
  
  def welcome_email(user)
      @user = user
      @url  = "http://floorstoreonthego.com"
      mail(:to => @user.email, :subject => "Welcome to DealerOnTheGo")
  end
  
end
