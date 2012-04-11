# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    user_id ""
    customer_id 1
    content "MyText"
  end
end
