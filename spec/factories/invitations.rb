# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    sender_id 1
    recipient_email "MyString"
    token "MyString"
    sent_at "2012-05-01 10:36:54"
  end
end
