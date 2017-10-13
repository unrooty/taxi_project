# Remove affiliate foreign key from employee
class RemoveAffiliateForeignKeyFromEmployee < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :employees, :affiliates
  end
end
