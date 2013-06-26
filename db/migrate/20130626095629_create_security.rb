class CreateSecurity < ActiveRecord::Migration
  def change
    create_table :securities do |t|
      t.string :symbol, null: false
      t.string :name, null: false

      t.integer :exchange_id, null: false
      t.foreign_key  :exchanges, dependent: :delete

      t.timestamps
    end
  end
end
