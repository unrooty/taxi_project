class Order::Create < Trailblazer::Operation
  extend Contract::DSL

  class Present < Trailblazer::Operation
    step Model(Order, :new)
    step Contract::Build(constant: Order::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :order)
  step Wrap ->(*, &block) { Order.transaction(&block) } {
    step :assign_user_to_order
    step Contract::Persist()
    step :set_default_tax_to_order
  }

  private

  def set_default_tax_to_order(options, *)
    options['model'].update(tax_id: Tax.where(by_default: true).last.id)
  end

  def assign_user_to_order(options, params, *)
    options['model'].user_id = unless params[:current_user].nil?
                                 params[:current_user].id
                               end
    true
  end
end
