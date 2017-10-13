# Adding foreign key cars to orders.
class AddCarsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :orders, :cars
  end
end
