module Admin::Car
  class Update < Trailblazer::Operation
    extend Update::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Car, :find_by)
      step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
      step self::Contract::Build(constant: Admin::Car::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :car)
    step self::Contract::Persist()
  end
end
