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
        unless Order.find(order_id).car_id.nil?
          errors.add(:order_id, "#{order_id} already has car.")
        end
      end

      def car_not_assigned
        car = Car.find(car_id)
        if car.car_status == 'ordered'
          errors.add(:car_id, " #{car.brand}
          #{car.car_model}(#{car.reg_number}) has already been assigned to order.")
        end
      end
    end
  end
end
