module Admin::Order
  module Contract
    class Create < Reform::Form
      #:property
      property :tax_id
      property :start_point
      property :end_point
      property :client_name
      property :client_phone
      property :order_status
      #:property end

      #:validation
      validates :start_point, :end_point, :client_name, presence: true
      validates :client_phone, presence: true,
                format: /\A\d{2}-\d{3}-\d{2}-\d{2}\z/
      #:validation end
    end
  end
end
