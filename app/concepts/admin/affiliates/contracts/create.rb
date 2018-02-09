module Admin::Affiliate
  module Contract
    class Create < Reform::Form
      #:property
      property :name
      property :address
      #:property end

      #:validation
      validates :name, :address, presence: true
      validates :name, length: { maximum: 25 }
      validates :address, length: { maximum: 25 }
      #:validation end
    end
  end
end
