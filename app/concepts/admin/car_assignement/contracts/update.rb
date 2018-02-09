module Admin::CarAssignment
  module Contract
    class Update < Reform::Form
      property :car_id

      validates :car_id, presence: true
      validate :car_not_assigned

      private

      def car_not_assigned
        if Car[car_id].car_status == :ordered
          errors.add(:car_id, " #{car.brand}
          #{car.car_model}(#{car.reg_number}) has already been assigned to order.")
        end
      end
    end
  end
end
