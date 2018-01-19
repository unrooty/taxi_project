class Car::Index < Trailblazer::Operation
  step :model!

  def model!(options, *)
    options['model'] = Car.all
  end
end