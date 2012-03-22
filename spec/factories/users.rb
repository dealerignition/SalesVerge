# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password "test"
    role "salesrep"

    dealer

    factory :owner do
      first_name "Owner"
      role "owner"
    end

    factory :salesrep do
      first_name "Salesrep"
      role "salesrep"

      factory :salesrep_with_customers do
        ignore do
          customer_count 15
        end

        after_create do |user, evaluator|
          FactoryGirl.create_list(:customer, evaluator.customer_count, :user => user)
        end
      end
    end

    factory :admin do
      first_name "Admin"
      role "admin"
    end
  end
end
