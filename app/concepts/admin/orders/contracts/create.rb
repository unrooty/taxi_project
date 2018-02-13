module Admin::Order
  module Contract
    class Create < Reform::Form
      #:property
      property :start_point
      property :end_point
      property :client_name
      property :client_phone
      #:property end

      #:validation
      validates :start_point, :end_point, :client_name, presence: true
      validates :client_phone, presence: true, length: { is: 9 }
      #:validation end
    end
  end
end
