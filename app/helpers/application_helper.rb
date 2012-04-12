module ApplicationHelper
  def you_or_they(user)
    current_user == user ? "you" : user.full_name
  end

  def to_sentence(model)
    if model.instance_of? Estimate
      "#{ you_or_they(model.user) } gave #{model.customer.first_name} an estimate for #{ number_to_currency(model.total) }."
    elsif model.instance_of? SampleCheckout
      "#{model.customer.first_name} checked-out #{ model.sample.name }."
    elsif model.instance_of? Note
      "#{ you_or_they(model.user) } created a note about #{ model.customer.first_name }."
    elsif model.instance_of? Customer
      "#{ you_or_they(model.user) } added #{ model.full_name } as a customer."
    else
    end
  end

end
