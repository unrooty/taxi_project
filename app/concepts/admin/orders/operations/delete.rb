module Admin::Order
  class Delete < Trailblazer::Operation
    step Model(Order, :find_by)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction { block.call } } {
      step :update_car_status_to_free!
      step :delete!
    }

    private

    def update_car_status_to_free!(_options, model:, **)
      model.car.update(car_status: 0) unless model.car.nil?
      true
    end

    def delete!(_options, model:, **)
      model.destroy
    end
  end
end
