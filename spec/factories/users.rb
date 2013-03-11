# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login_name "MyString"
    display_name "MyString"
    password_digest "MyString"
  end
end
