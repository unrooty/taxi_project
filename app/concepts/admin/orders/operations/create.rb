module Admin::Order
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Order, :new)
      step Policy::Pundit(Admin::OrdersPolicy, :can_work_with_order?)
      step self::Contract::Build(constant: Admin::Order::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :order)
    step Wrap ->(*, &block) { Order.db.transaction { block.call } } {
      step :assign_user_id_to_order
      step :set_order_status_to_new
      step :set_default_tax
      step self::Contract::Persist()
    }

    private

    def set_order_status_to_new(_options, model:, **)
      model.order_status = 'New'
    end

    def assign_user_id_to_order(_options, model:, current_user:, **)
      model.user_id = (current_user.id unless current_user.nil?)
      true
    end

    def set_default_tax(_options, model:, **)
      model.tax_id = 1
    end
  end
end
