# Invoice model class.
class Invoice < Sequel::Model

  one_to_one :order

  plugin :enum
  enum :invoice_status, %i[paid unpaid partially_paid]
end
