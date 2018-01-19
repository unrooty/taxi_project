class Car::Create < Trailblazer::Operation
  extend Contract::DSL
  class Present < Trailblazer::Operation
    step Model(Car, :new)
    step Contract::Build(constant: Car::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :car)
  step Contract::Persist()
end