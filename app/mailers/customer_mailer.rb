class CustomerMailer < ActionMailer::Base
  default from: "support@dealerignition.com"

  def thank_you_email(customer)
      @customer = customer
      @url  = "http://floorstoreonthego.com"
      mail(:to => customer.email, :subject => "Thank-you for your interest in our store")
  end

end
