module Admin::Order
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL

    class Present < Trailblazer::Operation
      step Model(Order, :new)
      step self::Contract::Build(constant: Admin::Order::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :order)
    step :assign_user_id_to_order
    step :set_order_status_to_new
    step :set_default_tax
    step self::Contract::Persist()

    private

    def set_order_status_to_new(options, *)
      options['model'].order_status = 0
    end

    def assign_user_id_to_order(options, params, *)
      options['model'].user_id = unless params[:current_user].nil?
                                   params[:current_user].id
                                 end
      true
    end

    def set_default_tax(options, *)
      options['model'].tax_id = 1
    end
  end
end
