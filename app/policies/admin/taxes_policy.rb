class Admin::TaxesPolicy
  def initialize(user, *)
    @user = user
  end

  def index?
    @user.role.in?(%w[admin manager driver dispatcher])
  end

  def can_manage?
    @user.role.in?(%w[admin manager])
  end
end
