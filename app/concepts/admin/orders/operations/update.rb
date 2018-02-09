module Admin::Order
  class Update < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Order, :[])
      step Policy::Pundit(Admin::OrdersPolicy, :can_work_with_order?)
      step self::Contract::Build(constant: Admin::Order::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :order)
    step self::Contract::Persist()
  end
end
