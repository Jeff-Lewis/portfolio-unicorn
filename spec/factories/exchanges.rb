require 'faker'

FactoryGirl.define do 
    factory :exchange do |f|
        f.name { %w(nasdaq lse nyse otcbb sgx).sample }
    end
end