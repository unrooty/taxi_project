# Invoice model class.
class Invoice < Sequel::Model
  one_to_one :order, key: :id

  STATUSES = [
    PAID = 'Paid'.freeze,
    UNPAID = 'Unpaid'.freeze,
    PARTIALLY_PAID = 'Partially paid'.freeze
  ].freeze
end
