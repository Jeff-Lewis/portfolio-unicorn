class AddFundamentals < ActiveRecord::Migration
  def change
    create_table :fundamentals do |t|

      #foreign key security_id
      t.integer :security_id, null: false
      t.foreign_key :securities, dependent: :restrict

      # market cap is always big, no need to store decimal
      t.decimal :market_cap, precision: 18, scale: 0

      t.decimal :avg_daily_volume, precision: 18, scale: 6

      # nullable column ammount - do not create the currency column
      t.money :week52_low, amount: { null: true }, currency: { present: false } 
      t.money :week52_high, amount: { null: true }, currency: { present: false }

      t.decimal :earning_per_share, precision: 18, scale: 6
      t.decimal :price_earning_ratio, precision: 18, scale: 6

      t.decimal :dividend_yield, precision: 18, scale: 6
      t.date :dividend_pay_date

      #average price per share, use Money type from the money gem 
      t.money :avg_price, currency: { present: false }

      t.timestamps
    end
  end
end