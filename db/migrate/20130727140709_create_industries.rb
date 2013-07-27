class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :industries, :name, unique: true
  end
end
