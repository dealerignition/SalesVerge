# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quote do
    quote_type "Quote"
  end

  factory :estimate, :class => Quote do
    quote_type "Estimate"
  end
end
