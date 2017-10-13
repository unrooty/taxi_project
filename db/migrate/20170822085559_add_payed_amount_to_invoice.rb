# Adding payed_amount column to invoices table.
class AddPayedAmountToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :payed_amount, :decimal
  end
end
