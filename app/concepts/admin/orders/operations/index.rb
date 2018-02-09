module Admin::Order
  class Index < Trailblazer::Operation
    step :model!
    step Policy::Pundit(Admin::OrdersPolicy, :can_work_with_order?)

    private

    def model!(options, params, *)
      options['model'] = Order.search_by_client_phone(params['desired_phone'])
    end
  end
end
