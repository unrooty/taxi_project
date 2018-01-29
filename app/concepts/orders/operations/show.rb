class Order::Show < Trailblazer::Operation
  step Model(Order, :find_by)
  step Policy::Pundit(OrdersPolicy, :access_allowed?)
end
