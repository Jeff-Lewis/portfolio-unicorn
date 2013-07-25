# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :portfolio do
    sequence(:name) {|n| "Portfolio #{n}"}
    user
  end
end
