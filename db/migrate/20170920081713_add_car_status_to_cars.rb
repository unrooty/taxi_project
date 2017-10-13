# Add car_status_id column and foreign key to cars
class AddCarStatusToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :car_status_id, :integer, default: 1, null: false
    add_foreign_key :cars, :car_statuses
  end
end
