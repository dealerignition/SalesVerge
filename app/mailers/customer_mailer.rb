class CustomerMailer < ActionMailer::Base
  # default from: "notifications@dealerbookapp.com"
  
  # NOTE: Every mailer must have a @dealer variable defined as the customer_mailer layout is expecting one
  # NOTE: Every mailer must have a @user variable defined as the signature partial is expecting one
  def thank_you_email(customer)
    @customer = customer
    @user = @customer.user
    @dealer = @user.dealer
    @url  = "http://floorstoreonthego.com"
    mail(:sender => @user.email, :to => @customer.email, :subject => "Thank-you for your interest in our store", :reply_to => @customer.user.email)
    
    @sent_email = SentEmail.new(:customer_id => @customer.id, :type => "thank_you")
    @sent_email.save
  end
  
  def quote(quote)
    @quote = quote
    @user = quote.user
    @customer = quote.customer
    @dealer = quote.user.dealer
    
    # Set the FROM header to include the user's name
    address = Mail::Address.new "notifications@dealerbookapp.com"
    address.display_name = @user.full_name
    mail(:from => address.format, :sender => @user.email, :to => @customer.email, :subject => "Here is your quote", :reply_to => @user.email)
    
    @sent_email = SentEmail.new(:customer_id => @customer.id, :type => "quote")
    @sent_email.save
  end
  
  def quote_won(quote)
    @quote = quote
    @user = quote.user
    @customer = quote.customer
    @dealer = quote.user.dealer
    mail(:sender => @user.email, :to => @customer.email, :subject => "Thank you for your purchase", :reply_to => @user.email)
    
    @sent_email = SentEmail.new(:customer_id => @customer.id, :type => "quote_won")
    @sent_email.save
  end
  
  def sample_checkout(sample_checkouts)
    sample_checkouts = [sample_checkouts, ] unless sample_checkouts.instance_of? Array
    @sample_checkouts = sample_checkouts
    @customer = sample_checkouts.first.customer
    @user = sample_checkouts.first.user
    @dealer = @user.dealer
    title = @sample_checkouts.count == 1 ? @sample_checkouts.first.sample.name : "some samples"
    
    # Set the FROM header to include the user's name
    address = Mail::Address.new "notifications@dealerbookapp.com"
    address.display_name = @user.full_name
    
    mail(:from => address.format, :sender => @user.email, :to => @customer.email, :subject => "Thank you for checking out #{title}!", :reply_to => @user.email)
    
    @sent_email = SentEmail.new(:customer_id => @customer.id, :type => "sample_checkout")
    @sent_email.save
  end

  def long_checkout_notification(sample_checkouts)
    sample_checkouts = [sample_checkouts, ] unless sample_checkouts.instance_of? Array
    @sample_checkouts = sample_checkouts
    @customer = sample_checkouts.first.customer
    @user = sample_checkouts.first.user
    @dealer = @user.dealer
    title = @sample_checkouts.count == 1 ? @sample_checkouts.first.sample.name : "some samples"
    
    # Set the FROM header to include the user's name
    address = Mail::Address.new "notifications@dealerbookapp.com"
    address.display_name = @user.full_name
    
    mail(:from => address.format, :sender => @user.email, :to => @customer.email, :subject => "You still have #{title}. Can we get our stuff back?", :reply_to => @user.email)
    sample_checkouts.each do |s|
      s.notifications_received = s.notifications_received + 1
      s.save
    end
    
    @sent_email = SentEmail.new(:customer_id => @customer.id, :type => "long_checkout")
    @sent_email.save
  end

end
