module Admin::Order
  class Show < Trailblazer::Operation
    step Model(Order, :[])
    step Policy::Pundit(Admin::OrdersPolicy, :can_work_with_order?)
  end
end
