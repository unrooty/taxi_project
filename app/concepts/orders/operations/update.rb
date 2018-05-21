class Order::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Order, :[])
    step Policy::Pundit(OrdersPolicy, :access_granted?)
    step Contract::Build(constant: Order::Contract::Create)
  end

  step Nested(Present)
  success :bring_number_to_right_format
  step Contract::Validate(key: :order)
  step Contract::Persist()

  private

  def bring_number_to_right_format(_options, params:, **)
    params['order']['client_phone'].gsub!(/[^\d]/, '')
  end
end
