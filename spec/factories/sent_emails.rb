# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sent_email do
    customer_id 1
    type ""
  end
end
