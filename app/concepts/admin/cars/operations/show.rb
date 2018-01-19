class Car::Show < Trailblazer::Operation
  step Model(Car, :find_by)
end