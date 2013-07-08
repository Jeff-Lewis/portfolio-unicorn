class AddActiveFieldToSecurity < ActiveRecord::Migration
  def change
    add_column :securities, :active, :boolean, null: false, default: true
  end
end
