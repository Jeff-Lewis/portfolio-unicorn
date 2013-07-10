# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'faker'

FactoryGirl.define do 
    factory :exchange do
        name { %w(nasdaq lse nyse otcbb sgx).sample }
    end

    factory :nasdaq, class: Exchange do
      name "nasdaq"
    end

    factory :lse, class: Exchange do
      name "lse"
    end
end
