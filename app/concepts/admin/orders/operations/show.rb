module Admin::Order
  class Show < Trailblazer::Operation
    step Model(Order, :find_by)
  end
end
