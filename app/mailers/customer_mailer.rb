class CustomerMailer < ActionMailer::Base
  default from: "notifications@dealeronthego.com"

  # NOTE: Every mailer must have a @company variable defined as the customer_mailer layout is expecting one
  # NOTE: Every mailer must have a @user variable defined as the signature partial is expecting one
  def quote(quote)
    @quote = quote
    @user = quote.user
    @customer = quote.customer
    @company = quote.user.company
    set_display_name
    mail(:from => @address.format, :sender => @user.email, :to => @customer.email, :subject => "Here is your quote", :reply_to => @user.email)

    SentEmail.create(:customer_id => @customer.id, :notification_type => "quote", :notification_type_id => @quote.id)
  end

  def quote_won(quote)
    @quote = quote
    @user = quote.user
    @customer = quote.customer
    @company = quote.user.company
    set_display_name
    mail(:from => @address.format, :sender => @user.email, :to => @customer.email, :subject => "Thank you for your purchase", :reply_to => @user.email)

    SentEmail.create(:customer_id => @customer.id, :notification_type => "quote_won", :notification_type_id => @quote.id)
  end

  def sample_checkout(sample_checkouts)
    sample_checkouts = [sample_checkouts, ] unless sample_checkouts.instance_of? Array
    @sample_checkouts = sample_checkouts
    @customer = sample_checkouts.first.customer
    @user = sample_checkouts.first.user
    @company = @user.company
    title = @sample_checkouts.count == 1 ? @sample_checkouts.first.sample.name : "some samples"

    set_display_name
    mail(:from => @address.format, :sender => @user.email, :to => @customer.email, :subject => "Thank you for checking out #{title}!", :reply_to => @user.email)

    SentEmail.create(:customer_id => @customer.id, :notification_type => "sample_checkout", :notification_type_id => @sample_checkouts.first.id)
  end

  def long_checkout_notification(sample_checkouts)
    sample_checkouts = [sample_checkouts, ] unless sample_checkouts.instance_of? Array
    @sample_checkouts = sample_checkouts
    @customer = sample_checkouts.first.customer
    @user = sample_checkouts.first.user
    @company = @user.company
    title = @sample_checkouts.count == 1 ? @sample_checkouts.first.sample.name : "some samples"
    set_display_name
    mail(:from => @address.format, :sender => @user.email, :to => @customer.email, :subject => "You still have #{title}. Can we get our stuff back?", :reply_to => @user.email)

    sample_checkouts.each do |s|
      s.notifications_received = s.notifications_received + 1
      s.save
    end

    SentEmail.create(:customer_id => @customer.id, :notification_type => "long_checkout", :notification_type_id => @sample_checkout.id)
  end

  private

  def set_display_name
    # Set the FROM header to include the user's name
    @address = Mail::Address.new "notifications@dealeronthego.com"
    @address.display_name = @user.full_name
  end

end
