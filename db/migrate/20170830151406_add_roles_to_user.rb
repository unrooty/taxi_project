# Add role column to users
class AddRolesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :integer, default: 5, null: false
    remove_column :users, :roles_mask
  end
end
