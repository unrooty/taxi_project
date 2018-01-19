class Order::Delete < Trailblazer::Operation
  step Model(Order, :find_by)
  step :delete!

  def delete!(_options, model:, **)
    model.destroy
  end
end