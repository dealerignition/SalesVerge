# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :charge do
    date "2012-03-08 11:04:03"
    description "MyText"
    quantity 1
    price 1.5
  end

  factory :charge2at1dot5, :class => Charge do
    date "2012-03-08 11:04:03"
    description "MyText"
    quantity 2
    price 1.5
  end

  factory :charge3at1dot2, :class => Charge do
    date "2012-03-08 11:04:03"
    description "MyText"
    quantity 3
    price 1.2
  end
end
