class AddSymbolIndexToSecurity < ActiveRecord::Migration
  def change
    add_index :securities, :symbol
  end
end
