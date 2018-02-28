module Admin::CarAssignment
  module Contract
    class Create < Reform::Form
      property :car_id
      property :order_id

      validates :car_id, presence: true
      validates :order_id, presence: true
      validate :car_not_assigned
      validate :order_has_no_car

      private

      def order_has_no_car
        if Order.where(id: order_id, car_id: nil).empty?
          errors.add(:order_id, "#{order_id} already has car.")
        end
      end

      def car_not_assigned
        if Car[car_id].car_status == 'Ordered'
          errors.add(:car_id, " #{car.brand}
          #{car.car_model}(#{car.reg_number}) has already been assigned to order.")
        end
      end
    end
  end
end
