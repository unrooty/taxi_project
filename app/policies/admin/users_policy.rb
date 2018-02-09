class Admin::UsersPolicy
  def initialize(user, *)
    @user = user
  end

  def can_manage?
    @user.role.in?(%w[admin manager])
  end
end
