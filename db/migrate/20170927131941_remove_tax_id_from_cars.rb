# Remove tax_id column from cars table
class RemoveTaxIdFromCars < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :cars, :taxes
    remove_column :cars, :tax_id
  end
end
