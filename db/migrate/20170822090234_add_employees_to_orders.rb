# Adding foreign key employees to orders.
class AddEmployeesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :orders, :employees, column: :dispatcher_id
  end
end
