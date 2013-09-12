# == Schema Information
#
# Table name: fundamentals
#
#  id                  :integer          not null, primary key
#  security_id         :integer          not null
#  market_cap          :integer
#  avg_daily_volume    :decimal(18, 6)
#  week52_low_udollar  :integer
#  week52_high_udollar :integer
#  earning_per_share   :decimal(18, 6)
#  price_earning_ratio :decimal(18, 6)
#  dividend_yield      :decimal(18, 6)
#  dividend_pay_date   :date
#  avg_price_udollar   :integer          not null
#  created_at          :datetime
#  updated_at          :datetime
#


class Fundamental < ActiveRecord::Base
  belongs_to :security
  validates :security_id, presence: true

  monetize :week52_low_udollar, allow_nil: true, numericality: { greater_than: 0 }
  monetize :week52_high_udollar, allow_nil: true, numericality: { greater_than: 0 }

  monetize :avg_price_udollar, numericality: { greater_than: 0 }
end
