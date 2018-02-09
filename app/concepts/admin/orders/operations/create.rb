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
      step :debug
      step self::Contract::Persist()
    }

    private

    def set_order_status_to_new(options, *)
      options[:model].order_status = :fresh
    end

    def assign_user_id_to_order(options, params, *)
      options[:model].user_id = unless params[:current_user].nil?
                                  params[:current_user].id
                                 end
      true
    end

    def set_default_tax(options, *)
      options[:model].tax_id = 1
    end

    def debug(options, *)
      p options
    end
  end
end
