# Add roles_mask column to users
class AddRolesMaskToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :roles_mask, :integer
  end
end
