FactoryGirl.define do
  factory :customer do
    first_name "Henry"
    last_name "Ignition"
    email "henry@dealerignition.com"
  end
  
  factory :bad_email, :class => Customer do
    first_name "Henry"
    last_name "Ignition"
    email "henry"
  end
  
end
