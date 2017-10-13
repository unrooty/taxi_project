# Add user_id column to car
class AddUserIdToCar < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :user_id, :integer
  end
end
