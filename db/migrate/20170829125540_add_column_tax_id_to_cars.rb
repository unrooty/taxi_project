# Add tax_id column and foreign key to cars
class AddColumnTaxIdToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :tax_id, :integer
    add_foreign_key :cars, :taxes
  end
end
