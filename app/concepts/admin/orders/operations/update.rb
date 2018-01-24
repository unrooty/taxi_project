module Admin::Order
  class Update < Trailblazer::Operation
    extend Update::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(Order, :find_by)
      step self::Contract::Build(constant: Admin::Order::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :order)
    step self::Contract::Persist()
  end
end
