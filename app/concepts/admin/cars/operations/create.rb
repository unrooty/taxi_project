module Admin::Car
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Car, :new)
      step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
      step self::Contract::Build(constant: Admin::Car::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :car)
    step Wrap ->(*, &block) { Car.db.transaction { block.call } } {
      step self::Contract::Persist()
      step :bind_car_to_manager_affiliate
    }

    private

    def bind_car_to_manager_affiliate(_options, model:, current_user:, **)
      if current_user.role == 'Manager'
        model.update(affiliate_id: current_user.affiliate_id)
      end
      true
    end
  end
end
