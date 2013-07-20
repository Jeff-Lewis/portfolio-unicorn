# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :portfolio do
    name Faker::Lorem.word
    user
  end
end
