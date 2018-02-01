module Admin::Car
  class Delete < Trailblazer::Operation
    step Model(Car, :find_by)
    step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
    step Wrap ->(*, &block) { Car.transaction { block.call } } {
      step :remove_from_orders!
      step :delete!
    }

    private

    def remove_from_orders!(options, *)
      options['model'].orders.update_all(car_id: nil)
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
