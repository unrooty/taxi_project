module Admin::User
  class Delete < Trailblazer::Operation
    step Model(User, :[])
    step Policy::Pundit(Admin::UsersPolicy, :can_manage?)
    step Wrap(SequelTransaction) {
      step :remove_from_orders!
      step :remove_from_cars!
      step :delete!
    }

    private

    def remove_from_cars!(_options, model:, **)
      model.car.update(user_id: User.first.id) if model.car
      true
    end

    def remove_from_orders!(_options, model:, **)
      model.orders.update_all(user_id: nil) unless model.orders.empty?
      true
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
