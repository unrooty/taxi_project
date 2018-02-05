class OrdersPolicy

  def initialize(user, model)
    @user = user
    @model = model
  end

  def access_granted?
    @user && @user.id == @model.user_id
  end

  def access_to_report_allowed?
    @user
  end
end
