class AddNameIndexToExchange < ActiveRecord::Migration
  def change
    add_index :exchanges, :name, unique: true
  end
end
