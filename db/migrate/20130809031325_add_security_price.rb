class AddSecurityPrice < ActiveRecord::Migration
  def change
    create_table :security_prices do |t|

      #foreign key security_id
      t.integer :security_id, null: false
      t.foreign_key :securities, dependent: :restrict

      t.money :last_price, amount: { null: true }
      t.money :bid, amount: { null: true }
      t.money :ask, amount: { null: true }

      t.money :open, amount: { null: true }
      t.money :high, amount: { null: true }
      t.money :low, amount: { null: true }
      t.money :previous_close, amount: { null: true }

      # nullable column ammount - do not create the currency column
      t.money :week52_low, amount: { null: true }
      t.money :week52_high, amount: { null: true }

      t.decimal :change, precision: 18, scale: 6

      # market cap is always big, no need to store decimal
      t.decimal :market_cap, precision: 18, scale: 0

      t.decimal :avg_daily_volume, precision: 18, scale: 6
      t.decimal :volume, precision: 18, scale: 6


      t.decimal :earning_per_share, precision: 18, scale: 6
      t.decimal :price_earning_ratio, precision: 18, scale: 6

      t.decimal :dividend_yield, precision: 18, scale: 6
      t.date :dividend_pay_date

      t.timestamps
    end
  end
end