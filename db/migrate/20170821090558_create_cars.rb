# Create cars table
class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.string :reg_number
      t.string :color
      t.string :type
      t.boolean :free
      t.references :affiliate, foreign_key: true

      t.timestamps
    end
  end
end
