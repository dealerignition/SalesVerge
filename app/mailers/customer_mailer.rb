class CustomerMailer < ActionMailer::Base
  default from: "notifications@dealerbookapp.com"
  
  # NOTE Every mailer must have @dealer variable defined as the customer_mailer layout is expecting one
  def thank_you_email(customer, dealer)
      @customer = customer
      @dealer = dealer
      @url  = "http://floorstoreonthego.com"
      mail(:to => @customer.email, :subject => "Thank-you for your interest in our store", :reply_to => "#{@customer.user.email}")
  end
  
  def estimate(estimate)
      @estimate = estimate
      @customer = estimate.customer
      @dealer = estimate.user.dealer
      mail(:to => @customer.email, :subject => "Here is your estimate", :reply_to => "#{@customer.user.email}")
  end
  
  def estimate_won(estimate)
    @estimate = estimate
    @customer = estimate.customer
    @dealer = estimate.user.dealer
    mail(:to => @customer.email, :subject => "Thank you for your purchase", :reply_to => "#{@customer.user.email}")
  end
  
  def sample_checkout(sample_checkout)
    @sample_checkout = sample_checkout
    @customer = sample_checkout.customer
    @dealer = sample_checkout.user.dealer
    mail(:to => @customer.email, :subject => "Thank you for checking out #{@sample_checkout.sample.name}", :reply_to => "#{@customer.user.email}")
  end
end
