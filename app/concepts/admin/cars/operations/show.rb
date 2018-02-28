module Admin::Car
  class Show < Trailblazer::Operation
    step Model(Car, :[])
    step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
  end
end
