module Admin::Order
  class Index < Trailblazer::Operation
    step :model!
    step Policy::Pundit(Admin::OrdersPolicy, :can_work_with_order?)

    private

    def model!(options, *)
      options[:model] = Order.all
    end
  end
end
