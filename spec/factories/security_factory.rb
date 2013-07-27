# == Schema Information
#
# Table name: securities
#
#  id          :integer          not null, primary key
#  symbol      :string(255)      not null
#  name        :string(255)      not null
#  exchange_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  active      :boolean          default(TRUE), not null
#

require 'faker'

FactoryGirl.define do 
  factory :security do
      symbol do #random symbol of 5 char with letter and digit
          o = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
          (0...5).map{ o[rand(o.length)] }.join
      end

      sequence(:name) {|n| "Company_#{n}"}
      exchange
      sector
  end

  factory :aapl, parent: :security do
    symbol "aapl"
    name "Apple"
    association :exchange, factory: :nasdaq
    association :sector, factory: :computer_manufacturing
  end

  factory :msft, parent: :security do
    symbol "msft"
    name "Microsoft"
    association :exchange, factory: :nasdaq
    association :sector, factory: :computer_software
  end
end
