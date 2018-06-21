module Admin::Invoice
  module Contract
    class Create < Reform::Form
      property :distance
      property :payed_amount
      property :additional_amount, virtual: true

      validates :distance, :payed_amount, presence: true
      validates :payed_amount, :distance, :additional_amount,
                numericality: { greater_than_or_equal_to: 0 }
    end
  end
end
