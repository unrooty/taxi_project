class ChangeTaxIdInOrder < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:orders, :tax_id, nil)
    change_column :orders, :tax_id, :integer, null: true
  end
end
