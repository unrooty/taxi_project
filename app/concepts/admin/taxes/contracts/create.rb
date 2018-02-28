module Admin::Tax
  module Contract
    class Create < Reform::Form
      #:property
      property :name
      property :cost_per_km
      property :basic_cost
      #:property end

      #:validation
      validates :name, :cost_per_km, :basic_cost, presence: true
      validates :cost_per_km, :basic_cost,
                numericality: { greater_than_or_equal_to: 0 }

      #:validation end
    end
  end
end
