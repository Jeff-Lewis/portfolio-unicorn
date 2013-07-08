require 'faker'

FactoryGirl.define do 
  factory :security do
      symbol do #random symbol of 5 char with letter and digit
          o = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
          (0...5).map{ o[rand(o.length)] }.join
      end

      name Faker::Company.name
      exchange
  end

  factory :aapl, class: Security do
    symbol "aapl"
    name "Apple"
    association :exchange, factory: :nasdaq
  end

  factory :msft, class: Security do
    symbol "msft"
    name "Microsoft"
    association :exchange, factory: :nasdaq
  end
end
