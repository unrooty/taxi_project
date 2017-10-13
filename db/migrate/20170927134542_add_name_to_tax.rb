# Add name column to tax table
class AddNameToTax < ActiveRecord::Migration[5.0]
  def change
    add_column :taxes, :name, :string
  end
end
