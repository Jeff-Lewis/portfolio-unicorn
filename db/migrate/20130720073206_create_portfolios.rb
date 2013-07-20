class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name

      t.integer :user_id, null: false
      t.foreign_key  :users, dependent: :delete

      t.timestamps
    end
  end
end
