FactoryGirl.define do
  factory :customer do
    first_name "Henry"
    last_name "Ignition"
    sequence(:email) { |n| "customer#{n}@example.com" }
  end
end
