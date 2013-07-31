class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :name, null: false

      t.integer :industry_id, null: false
      t.foreign_key  :industries, dependent: :delete

      t.timestamps
    end

    add_index :sectors, [:industry_id, :name], unique: true

    unkown_industry = Industry.create(name: 'unknown')
    Sector.create(name: 'unknown', industry: unkown_industry)
  end
end
