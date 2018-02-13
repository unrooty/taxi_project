class Order::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Order, :new)
    step Contract::Build(constant: Order::Contract::Create)
  end

  step Nested(Present)
  step :bring_number_to_right_format
  step Contract::Validate(key: :order)
  step Wrap ->(*, &block) { Order.db.transaction { block.call } } {
    step :assign_user_to_order
    step Contract::Persist()
    step :set_default_tax_to_order
  }

  private

  def bring_number_to_right_format(_options, params:, **)
    params['order']['client_phone'].gsub!(/[^\d]/, '')
  end

  def set_default_tax_to_order(_options, model:, **)
    model.update(tax_id: Tax.where(by_default: true).last.id)
  end

  def assign_user_to_order(_options, model:, current_user:, **)
    model.user_id = if current_user
                      current_user.id
                    end
    true
  end
end
