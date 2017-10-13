# Invoice model class.
class Invoice < ApplicationRecord
  belongs_to :order, optional: true

  validates :distance, :invoice_status, presence: true
  validates :order, uniqueness: true
  validates :distance, numericality: { greater_than_or_equal_to: 0 }
  validates :payed_amount, numericality: { greater_than_or_equal_to: 0 }

  enum invoice_status: %w[paid unpaid partially_paid]
end
