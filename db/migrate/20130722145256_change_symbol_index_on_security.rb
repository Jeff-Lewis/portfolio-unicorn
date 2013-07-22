class ChangeSymbolIndexOnSecurity < ActiveRecord::Migration
  def change
    add_index :securities, :exchange_id

    remove_index :securities, :symbol
    add_index :securities, [:symbol, :exchange_id], unique: true
  end
end
