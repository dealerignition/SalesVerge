module AppointmentsHelper
  def customers_to_json
    @customers = Customer.select("email, id")
    @customers.to_json
  end
end
