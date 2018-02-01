module Admin::User
  class Delete < Trailblazer::Operation
    step Model(User, :find_by)
    step Wrap ->(*, &block) { User.transaction { block.call } } {
      step :remove_from_orders!
      step :remove_from_cars!
      step :delete!
    }

    private

    def remove_from_cars!(_options, model:, **)
      model.cars.update_all(user_id: nil)
    end

    def remove_from_orders!(_options, model:, **)
      model.orders.update_all(user_id: nil)
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
