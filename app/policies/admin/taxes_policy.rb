class Admin::TaxesPolicy
  def initialize(user, *)
    @user = user
  end

  def index?
    @user.role.in?(%i[administrator manager driver dispatcher])
  end

  def can_manage?
    @user.role.in?(%i[administrator manager])
  end
end
