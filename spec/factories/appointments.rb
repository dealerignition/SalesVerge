# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :appointment do
    date "2012-03-07"
    time "2012-03-07 09:05:39"
    status "Pending"

    customer
    user_id 1
  end
end
