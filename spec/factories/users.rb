# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login_name "bob"
    display_name "Bob"
    password "opensesame!"
  end
end
