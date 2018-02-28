module Admin::Car
  class Delete < Trailblazer::Operation
    step Model(Car, :[])
    step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
    step Wrap ->(*, &block) { Car.db.transaction { block.call } } {
      step :remove_from_orders!
      step :delete!
    }

    private

    def remove_from_orders!(_options, model:, **)
      model.orders.update_all(car_id: nil) unless model.orders.empty?
      true
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
