module Admin::Car
  module Contract
    class Create < Reform::Form
      include ActiveModel::Validations
      property :brand
      property :car_model
      property :reg_number
      property :color
      property :style
      property :user_id
      property :affiliate_id

      validates :brand, :user_id, :affiliate_id,
                :car_model, :reg_number, :color, :style, presence: true
      validates :reg_number, format: /\A[A-Z]{2}-\d{4}-[1-7]/, uniqueness: true
      validates :brand, :car_model, :color, :style, length: { maximum: 25 }
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
