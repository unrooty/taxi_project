# Initial database table for tax model.
class CreateTaxes < ActiveRecord::Migration[5.0]
  def change
    create_table :taxes do |t|
      t.decimal :cost_per_km
      t.decimal :basic_cost
      t.timestamps
    end
  end
end
