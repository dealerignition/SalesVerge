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

  def to_sentence(model)
    if model.instance_of? Quote
      if model.status == "won"
        "#{model.customer.full_name} <span class='quote-won'>purchased a quote</span> for <strong>#{ number_to_currency(model.total) }</strong>".html_safe
      elsif model.status == "lost"
        "#{model.customer.full_name} <span class='danger'>declined a quote</span> for <strong>#{ number_to_currency(model.total) }</strong>".html_safe
      elsif model.status == "emailed"
        "<h4>#{model.customer.full_name}</h4> Emailed quote worth <strong>#{ number_to_currency(model.total) }</strong>".html_safe
      else
        "<h4>#{model.customer.full_name}</h4> Started quote for worth <strong>#{ number_to_currency(model.total) }</strong>".html_safe
      end
    elsif model.instance_of? SampleCheckout
      if model.checkin_time?
        "<h4>#{model.customer.full_name}</h4> <span class='sample'>checked-<span class='sample_in'>in</span></span> #{ model.sample.name }".html_safe
      else
        "<h4>#{model.customer.full_name}</h4> <span class='sample'>checked-<span class='sample_out'>out</span></span> #{ model.sample.name }".html_safe
      end
    elsif model.instance_of? Note
      "<h4>#{ model.customer.full_name }</h4> New <span class='note'>note</span> about ".html_safe
    elsif model.instance_of? Customer
      "<h4>#{ model.full_name }</h4> New customer".html_safe
    else
    end
  end

end
