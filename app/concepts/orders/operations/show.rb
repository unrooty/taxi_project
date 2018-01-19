class Order::Show < Trailblazer::Operation
  step Model(Order, :find_by)
end