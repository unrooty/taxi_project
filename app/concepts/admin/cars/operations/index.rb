module Admin::Car
  class Index < Trailblazer::Operation
    step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
    step :manager_model!
    step :admin_model!

    private

    def admin_model!(options, *)
      options[:model] = Car.all if options[:current_user].role == :administrator
      true
    end

    def manager_model!(options, *)
      options[:model] = Car.where(affiliate_id:
                                       options[:current_user].affiliate_id)
    end
  end
end
