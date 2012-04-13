module ApplicationHelper
  def you_or_they(user)
    current_user == user ? "you" : user.full_name
  end

  def to_sentence(model)
    if model.instance_of? Estimate
      "#{ you_or_they(model.user) } gave #{model.customer.first_name} an <span class='estimate'>estimate</span> for #{ number_to_currency(model.total) }.".html_safe
    elsif model.instance_of? SampleCheckout
      if model.checkin_time?
        "#{model.customer.first_name} <span class='sample'>checked-in</span> #{ model.sample.name }.".html_safe
      else
        "#{model.customer.first_name} <span class='sample'>checked-out</span> #{ model.sample.name }.".html_safe
      end
    elsif model.instance_of? Note
      "#{ you_or_they(model.user) } created a <span class='note'>note</span> about #{ model.customer.first_name }.".html_safe
    elsif model.instance_of? Customer
      "#{ you_or_they(model.user) } added #{ model.full_name } as a customer.".html_safe
    else
    end
  end

end
