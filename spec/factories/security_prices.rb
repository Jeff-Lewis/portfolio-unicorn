# Read about factories at https://github.com/thoughtbot/factory_girl

PRICES = [0.01, 0.1, 1.0, 10.0, 100.0, 1000.0, 10000.0]
#from 1 Trillion to 1 Million
MARKET_CAPS = [1_000_000_000_000, 100_000_000_000, 1_000_000_000, 100_000_000, 10_000_000, 1_000_000]
VOLUMES = [1_000_000_000, 100_000_000, 1_000_000, 10_000, 1_000, 100, 10]

FactoryGirl.define do
  factory :security_price do
    security

    sequence(:last_price) {|n| PRICES[n % PRICES.count]} 
    sequence(:bid) {|n| PRICES[n % PRICES.count] * 0.99 }
    sequence(:ask) {|n| PRICES[n % PRICES.count] * 1.01 } 

    sequence(:open) {|n| PRICES[n % PRICES.count] } 
    sequence(:high) {|n| PRICES[n % PRICES.count] * 1.05  } 
    sequence(:low) {|n| PRICES[n % PRICES.count] * 0.95 } 
    sequence(:previous_close) {|n| PRICES[n % PRICES.count]} 

    sequence(:week52_low_udollar) {|n| PRICES[n % PRICES.count] * 0.8 } 
    sequence(:week52_high_udollar) {|n| PRICES[n % PRICES.count] * 1.2 } 

    change 0.0123

    sequence(:market_cap) {|n| MARKET_CAPS[n % MARKET_CAPS.count] }

    sequence(:avg_daily_volume) {|n| VOLUMES[n % VOLUMES.count] }
    sequence(:volume) {|n| VOLUMES[n % VOLUMES.count] * 0.1 }

    earning_per_share 1.5
    price_earning_ratio 2.34
    dividend_yield 1.3
    dividend_pay_date DateTime.new(2013, 9, 13, 11, 30, 0, '+7')
    
  end

  factory :aapl_price, parent: :security_price do
    association :security, factory: :aapl
  end
end