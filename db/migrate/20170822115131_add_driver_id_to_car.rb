# Add driver_id column and foreign key to car
class AddDriverIdToCar < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :driver_id, :integer
    add_foreign_key :cars, :employees, column: :driver_id
  end
end
