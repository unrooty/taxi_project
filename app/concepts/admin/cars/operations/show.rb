module Admin::Car
  class Show < Trailblazer::Operation
    step Model(Car, :find_by)
    step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
  end
end
