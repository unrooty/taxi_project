class AddByDefaultToTaxes < ActiveRecord::Migration[5.1]
  def change
    add_column :taxes, :by_default, :boolean, default: false, null: false
  end
end
