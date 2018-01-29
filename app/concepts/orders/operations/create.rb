class Order::Create < Trailblazer::Operation
  extend Contract::DSL

  class Present < Trailblazer::Operation
    step Model(Order, :new)
    step Contract::Build(constant: Order::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :order)
  step :set_orders_status
  step :assign_user_id_to_order
  step Contract::Persist()

  private

  def set_order_status(options, *)
    options['model'].order_status = 0
  end

  def assign_user_id_to_order(options, params, *)
    options['model'].user_id = unless params[:current_user].nil?
                                 params[:current_user].id
                               end
    true
  end
end
