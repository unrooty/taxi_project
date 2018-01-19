class Car::Delete < Trailblazer::Operation
  step Model(Car, :find_by)
  step :remove_from_orders!
  step :delete!

  def remove_from_orders!(options, *)
    p options['model'].orders.update_all(car_id: nil)
  end

  def delete!(_options, model:, **)
    model.destroy
  end
end