# Add car status column to cars table
class AddCarStatusToCarsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :car_status, :integer, default: 0, null: false
  end
end
