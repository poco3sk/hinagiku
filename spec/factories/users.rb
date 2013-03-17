# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:login_name) { |n| "name #{n}" }
    sequence(:display_name) { |n| "Name #{n}" }
    password "opensesame!"
  end
end
