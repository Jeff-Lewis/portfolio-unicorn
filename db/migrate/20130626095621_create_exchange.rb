class CreateExchange < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
