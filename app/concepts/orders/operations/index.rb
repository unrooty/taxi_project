class Order::Index < Trailblazer::Operation
  step :model!

  private

  def model!(options, current_user:, **)
    options[:model] = current_user.orders
  end
end
