class AddFkIndexesToPosition < ActiveRecord::Migration
  def change
    add_index :positions, :portfolio_id
    add_index :positions, :security_id
  end
end
