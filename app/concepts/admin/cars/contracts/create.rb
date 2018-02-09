require 'reform/form/validation/unique_validator'

module Admin::Car
  module Contract
    class Create < Reform::Form
      property :brand
      property :car_model
      property :reg_number
      property :color
      property :style
      property :user_id
      property :affiliate_id

      validates :brand, :car_model, :reg_number, :color, :style, presence: true
      validates :reg_number, format: /\A[A-Z]{2}-\d{4}-\d/ # , unique: true
      validates :brand, :car_model, :color, :style, length: { maximum: 15 }
      validate :user_has_no_car

      private

      def user_has_no_car
        user = User[user_id]
        if user.car && user.car.user_id != user.id
          errors.add('Водитель', "#{user.first_name}
          #{user.last_name} уже назначен на машину.")
        end
      end
    end
  end
end
