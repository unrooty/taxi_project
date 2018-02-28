module Admin::User
  class Index < Trailblazer::Operation
    step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
    step :manager_model!
    step :admin_model!

    private

    def admin_model!(options, current_user:, **)
      options[:model] = User.all if current_user.role == 'Admin'
      true
    end

    def manager_model!(options, *)
      options[:model] = User.where(affiliate_id:
                                       options[:current_user].affiliate_id)
    end
  end
end
