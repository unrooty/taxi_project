class Admin::InvoicesPolicy
  def initialize(user, *)
    @user = user
  end

  def can_work_with_invoice?
    @user.role.in?(%i[administrator manager driver dispatcher])
  end
end
