# Invoice model class.
class Invoice < ApplicationRecord
  belongs_to :order, optional: true

  enum invoice_status: %w[paid unpaid partially_paid]
end
