class Order::GeneratePdfWithOrders < Trailblazer::Operation
  step Policy::Pundit(OrdersPolicy, :access_granted?)
  step :find_all_orders

  private

  def find_all_orders(options, current_user:, **)
    options[:model] = current_user.orders
  end
end
