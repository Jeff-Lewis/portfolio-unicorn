# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    username Faker::Name.first_name
    password "12345678"
    password_confirmation "12345678"
  end
end
