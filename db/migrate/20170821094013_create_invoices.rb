# Initial database table for invoice model.
class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.decimal :distance
      t.decimal :total_price
      t.integer :status_id
      t.timestamps
    end
    add_foreign_key :invoices, :statuses
  end
end
