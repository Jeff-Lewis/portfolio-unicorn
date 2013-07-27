# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sector do
    sequence(:name) {|n| "Sector_#{n}"}
    industry
  end

  factory :computer_manufacturing, parent: :sector do
    name 'computer manufacturing'
    association :industry, factory: :technology
  end

  factory :computer_software, parent: :sector do
    name 'computer software: prepackaged software'
    association :industry, factory: :technology
  end
end
