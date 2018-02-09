class Admin::UsersPolicy
  def initialize(user, *)
    @user = user
  end

  def can_manage?
    @user.role.in?(%i[administrator manager])
  end
end
