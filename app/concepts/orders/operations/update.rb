class Order::Update < Trailblazer::Operation
  extend Contract::DSL
  class Present < Trailblazer::Operation
    step Model(Order, :find_by)
    step Contract::Build(constant: Order::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :order)
  step Contract::Persist()
end