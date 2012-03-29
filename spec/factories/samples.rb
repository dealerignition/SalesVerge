FactoryGirl.define do
  factory :sample do
    sequence(:dealer_sample_id) { |n| "#{n}" }
    sequence(:name) { |n| "SuperDuper Sample #{n}" }
    sample_type "The Usual"
  end
end
