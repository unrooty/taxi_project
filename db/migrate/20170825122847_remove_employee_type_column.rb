# Rename type column to role
class RemoveEmployeeTypeColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :employees, :type, :role
  end
end
