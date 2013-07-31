class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|

      #foreign key portfolio_id
      t.integer :portfolio_id, null: false
      t.foreign_key  :portfolios, dependent: :delete

      #foreign key security_id
      t.integer :security_id, null: false
      t.foreign_key :securities, dependent: :restrict

      #how many shares on the position
      t.integer :quantity, null: false

      #average price per share, use Money type from the money gem 
      t.money :avg_price, currency: { present: false }

      t.timestamps
    end
  end
end
