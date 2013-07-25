# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    sequence(:username) {|n| "#{n}_#{Faker::Name.first_name}" }
    password "12345678"
    password_confirmation "12345678"
  end

  factory :invalid_user, parent: :user do
    email nil
  end

end
