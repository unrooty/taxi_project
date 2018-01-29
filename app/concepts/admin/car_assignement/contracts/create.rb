module Admin::CarAssignment
  module Contract
    class Create < Reform::Form

      property :car_id
      property :order_id

      validates :car_id, presence: true
    end
  end
end
