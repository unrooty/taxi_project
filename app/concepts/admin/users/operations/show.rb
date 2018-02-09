module Admin::User
  class Show < Trailblazer::Operation
    step Model(User, :[])
    step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
  end
end
