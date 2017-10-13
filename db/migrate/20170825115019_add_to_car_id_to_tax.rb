# Add car_id column to tax table
class AddToCarIdToTax < ActiveRecord::Migration[5.0]
  def change
    add_column :taxes, :car_id, :integer
  end
end
