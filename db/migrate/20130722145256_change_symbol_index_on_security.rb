class ChangeSymbolIndexOnSecurity < ActiveRecord::Migration
  def self.up
    add_index :securities, :exchange_id

    remove_index :securities, :symbol
    add_index :securities, [:symbol, :exchange_id], unique: true
  end

  def self.down
    remove_index :securities, [:symbol, :exchange_id]
    add_index :securities, :symbol
    
    remove_index :securities, :exchange_id
  end
end
