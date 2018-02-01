module Admin::Car
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Car, :new)
      step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
      step self::Contract::Build(constant: Admin::Car::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :car)
    step Wrap ->(*, &block) { Car.transaction { block.call } } {
      step self::Contract::Persist()
      step :bind_car_to_manager_affiliate
    }

    def bind_car_to_manager_affiliate(options, *)
      if options['current_user'].role == 'manager'
        options['model'].update(affiliate_id: options['current_user'].affiliate_id)
      end
      true
    end
  end
end
