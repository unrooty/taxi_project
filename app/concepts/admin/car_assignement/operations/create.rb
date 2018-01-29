
module Admin::CarAssignment
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(OpenStruct, :new)
      step self::Contract::Build(constant:
                                     Admin::CarAssignment::Contract::Create)
    end

    step Nested(Present)
    step self::Contract::Validate(key: :car_assignment)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction { block.call } } {
      step :find_car
      step :find_order
      step :update_car_status_if_car_not_ordered
      step :update_order_status_if_order_has_no_car
      step :assign_car_to_order
      step :send_car_assignment_email_to_user
    }

    private

    def find_car(options, *)
      @car = Car.find(options['params']['car_assignment']['car_id'])
    end

    def find_order(options, *)
      @order = Order.find(options['params']['order_id'])
    end

    def update_car_status_if_car_not_ordered(*)
      @car.update(car_status: 1) unless @car.car_status == ('ordered')
    end

    def update_order_status_if_order_has_no_car(*)
      @order.update(order_status: 1) if @order.car_id.nil?
    end

    def assign_car_to_order(*)
      @order.update(car_id: @car.id)
    end

    def send_car_assignment_email_to_user(*)
      UserMailer.car_assignment_mail(@order.user, @car) if @order.user_id

      true
    end
  end
end
