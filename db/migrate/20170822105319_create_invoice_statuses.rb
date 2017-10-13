# Initial database table for invoice status model.
class CreateInvoiceStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_statuses do |t|
      t.string :title
      t.timestamps
    end
  end
end
