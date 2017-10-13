# Remove driver_id column from cars table (useless)
class RemoveDriverIdFromCars < ActiveRecord::Migration[5.0]
  def change
    remove_column :cars, :driver_id
  end
end
