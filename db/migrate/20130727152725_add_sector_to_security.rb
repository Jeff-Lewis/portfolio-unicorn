class AddSectorToSecurity < ActiveRecord::Migration

  def self.up
    # we want to create a foreign key on sector_id and we want it to be non-null,
    # 1) create a nullable column sector_id
    # 2) set a default value
    # 3) change column to be non-nullable
    add_column :securities, :sector_id, :integer
  
    default_sector = Sector.find_by(name: 'unknown')
    say_with_time "set securities sector to #{default_sector.inspect}" do
      Security.reset_column_information
      Security.update_all({sector_id: default_sector.id})
    end

    change_column :securities, :sector_id, :integer, :null => false
    add_foreign_key :securities, :sectors, dependent: :nullify
    add_index :securities, :sector_id
  end

  def self.down
    remove_index :securities, :sector_id
    remove_foreign_key :securities, :sectors
    remove_column :securities, :sector_id
  end
end
