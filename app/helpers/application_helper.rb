module ApplicationHelper
  def you_or_they(user)
    if user.instance_of? User
      # We were passed a User
      current_user == user ? "You" : user.full_name
    else
      # We were passed a user id.
      current_user.id == user ? "You" : User.find(user).full_name
    end
  end
  
  def sample_name_stream(sample_checkouts)
      @sample_checkouts = sample_checkouts
      @names = []
      @sample_checkouts.each do |s|
        @names += [s.sample.name.capitalize]
      end
      if @names.count > 1
        [@names[0...-1].join(", "), @names.last].join(", and ")
      else
        @names.join
      end
  end

  def to_sentence(model)
    if model.instance_of? Quote
      if model.status == "won"
        "#{model.customer.first_name} <span class='quote-won'>purchased a quote</span> for #{ number_to_currency(model.total) }".html_safe
      elsif model.status == "lost"
        "#{model.customer.first_name} <span class='danger'>declined a quote</span> for #{ number_to_currency(model.total) }".html_safe
      elsif model.status == "emailed"
        "#{ you_or_they(model.user_id) } emailed a <span class='quote'>quote</span> to #{model.customer.first_name} worth #{ number_to_currency(model.total) }".html_safe
      else
        "#{ you_or_they(model.user_id) } started a <span class='quote'>quote</span> for #{model.customer.first_name} worth #{ number_to_currency(model.total) }".html_safe
      end
    elsif model.instance_of? SampleCheckoutSet
      if model.checkin_time?
        "#{model.customer.first_name} <span class='sample'>checked-<span class='sample_in'>in</span></span> #{ sample_name_stream(model.sample_checkouts) }".html_safe
      else
        "#{model.customer.first_name} <span class='sample'>checked-<span class='sample_out'>out</span></span> #{ sample_name_stream(model.sample_checkouts) }".html_safe
      end
    elsif model.instance_of? Note
      "#{ you_or_they(model.user_id) } created a <span class='note'>note</span> about #{ model.customer.first_name }".html_safe
    elsif model.instance_of? Customer
      "#{ you_or_they(model.user_id) } added #{ model.full_name } as a <span class='customer'>customer</span>".html_safe
    else
    end
  end

end
