# Remove car_id column from cars
class RemoveCarIdFromTaxes < ActiveRecord::Migration[5.0]
  def change
    remove_column :taxes, :car_id
  end
end
