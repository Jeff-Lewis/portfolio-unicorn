# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    portfolio
    security
    quantity { [10000000, 1000000, 10000, 1000, 100, 10].flat_map { |e| [e,-e] }.sample }
    avg_price { [0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0, 10000.0].sample }
  end
end
