# == Schema Information
#
# Table name: positions
#
#  id                 :integer          not null, primary key
#  portfolio_id       :integer          not null
#  security_id        :integer          not null
#  quantity           :integer          not null
#  avg_price_cents    :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Position < ActiveRecord::Base

  belongs_to :portfolio
  validates :portfolio, presence: true

  belongs_to :security
  validates :security_id, presence: true
  validate :unique_open_position_on_portfolio

  #generate a avg_price property of type Money, it performs validation (see config/initializers/money.rb)
  monetize :avg_price_udollar, numericality: { greater_than: 0 }

  validates :quantity, presence: true


  def open?
    quantity != 0
  end

  def closed?
    !open?
  end

  private
    def unique_open_position_on_portfolio
      if similar_position_exists?
        errors.add(:quantity, "invalid as there is already an open position on the same security and portfolio");
      end
    end

    def similar_position_exists?
      return false if quantity.nil? #no need to query the db if quanity is not set

      r = Position.where("portfolio_id = ? and security_id = ?", portfolio_id, security_id)
      r = r.where(quantity > 0 ? "quantity > 0" : "quantity < 0" )
      unless id.nil?
        r = r.where("id != ?", id) #dont take into account this instance.
      end
      r.exists?
    end

end
