module Admin::User
  class Show < Trailblazer::Operation
    step Model(User, :find_by)
    step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
  end
end
