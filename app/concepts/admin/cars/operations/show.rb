module Admin::Car
  class Show < Trailblazer::Operation
    step Model(Car, :find_by)
  end
end
