# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password "test"
  end
end
