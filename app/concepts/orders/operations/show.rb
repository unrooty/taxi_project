class Order::Show < Trailblazer::Operation
  step Model(Order, :[])
  step Policy::Pundit(OrdersPolicy, :access_granted?)
end
