module Admin::Car
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Car, :new)
      step self::Contract::Build(constant: Admin::Car::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :car)
    step self::Contract::Persist()
  end
end
