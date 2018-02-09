class AddDeletedToTaxes < ActiveRecord::Migration[5.1]
  def change
    add_column :taxes, :deleted, :boolean, null: false, default: false
  end
end
