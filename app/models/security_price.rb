# == Schema Information
#
# Table name: security_prices
#
#  id                     :integer          not null, primary key
#  security_id            :integer          not null
#  last_price_udollar     :integer
#  bid_udollar            :integer
#  ask_udollar            :integer
#  open_udollar           :integer
#  high_udollar           :integer
#  low_udollar            :integer
#  previous_close_udollar :integer
#  week52_low_udollar     :integer
#  week52_high_udollar    :integer
#  change                 :decimal(18, 6)
#  market_cap             :integer
#  avg_daily_volume       :decimal(18, 6)
#  volume                 :decimal(18, 6)
#  earning_per_share      :decimal(18, 6)
#  price_earning_ratio    :decimal(18, 6)
#  dividend_yield         :decimal(18, 6)
#  dividend_pay_date      :date
#  created_at             :datetime
#  updated_at             :datetime
#


class SecurityPrice < ActiveRecord::Base
  belongs_to :security
  validates :security_id, presence: true

   [:last_price, :bid, :ask, :open, :high, :low, :previous_close, :week52_low, :week52_high ].each do |attrib|
    monetize "#{attrib}_udollar", allow_nil: true, numericality: { greater_than: 0 }

    alias_attribute :eps, :earning_per_share
    alias_attribute :pe, :price_earning_ratio
  end

end
