class Order::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Order, :[])
    step Policy::Pundit(OrdersPolicy, :access_granted?)
    step Contract::Build(constant: Order::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :order)
  step Contract::Persist()
end
