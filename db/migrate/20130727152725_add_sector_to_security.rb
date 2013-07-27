class AddSectorToSecurity < ActiveRecord::Migration
  def change
    add_column :securities, :sector_id, :integer, null: false
    add_foreign_key :securities, :sectors, dependent: :nullify
    add_index :securities, :sector_id
  end
end
