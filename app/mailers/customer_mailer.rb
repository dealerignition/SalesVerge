class CustomerMailer < ActionMailer::Base
  default from: "notifications@dealerbookapp.com"

  # NOTE: Every mailer must have a @company variable defined as the customer_mailer layout is expecting one
  # NOTE: Every mailer must have a @user variable defined as the signature partial is expecting one
  def thank_you_email(customer, company)
    @customer = customer
    @company = company
    @url  = "http://floorstoreonthego.com"
    mail(:to => @customer.email, :subject => "Thank-you for your interest in our store", :reply_to => "#{@customer.user.email}")
  end

  def quote(quote)
    @quote = quote
    @user = quote.user
    @customer = quote.customer
    @company = quote.user.company
    mail(:to => @customer.email, :subject => "Here is your quote", :reply_to => "#{@customer.user.email}")
  end

  def quote_won(quote)
    @quote = quote
    @user = quote.user
    @customer = quote.customer
    @company = quote.user.company
    mail(:to => @customer.email, :subject => "Thank you for your purchase", :reply_to => "#{@customer.user.email}")
  end

  def sample_checkout(sample_checkouts)
    sample_checkouts = [sample_checkouts, ] unless sample_checkouts.instance_of? Array
    @sample_checkouts = sample_checkouts
    @customer = sample_checkouts.first.customer
    @user = sample_checkouts.first.user
    @company = @user.company
    title = @sample_checkouts.count == 1 ? @sample_checkouts.first.sample.name : "some samples"
    mail(:to => @customer.email, :subject => "Thank you for checking out #{title}!", :reply_to => "#{@customer.user.email}")
  end
end
