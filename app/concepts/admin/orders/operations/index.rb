module Admin::Order
  class Index < Trailblazer::Operation
    step :model!

    private

    def model!(options, params, *)
      options['model'] = Order.search_by_client_phone(params['desired_phone'])
    end
  end
end
