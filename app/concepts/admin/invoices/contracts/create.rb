module Admin::Invoice
  module Contract
    class Create < Reform::Form
      property :distance
      property :payed_amount

      validates :distance, :payed_amount, presence: true
      validates :distance, numericality: { greater_than_or_equal_to: 0 }
      validates :payed_amount, numericality: { greater_than: 0 }
    end
  end
end
