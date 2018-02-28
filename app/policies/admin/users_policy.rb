class Admin::UsersPolicy
  def initialize(user, *)
    @user = user
  end

  def can_manage?
    @user.role.in?(%w[Admin Manager])
  end
end
