# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer_extension do
    customer_id 1
    age "MyString"
    gender "MyString"
    household_income "MyString"
    home_owner_status "MyString"
    home_market_value "MyString"
    home_propery_value "MyString"
    length_of_residence "MyString"
    education "MyString"
    zip "MyString"
  end
end
