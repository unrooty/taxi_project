
module Admin::CarAssignment
  class Create < Trailblazer::Operation
    extend Create::Contract::DSL
    class Present < Trailblazer::Operation
      step Model(OpenStruct, :new)
      step self::Contract::Build(constant:
                                     Admin::CarAssignment::Contract::Create)
    end

    step Nested(Present)
    step :add_order_id_to_car_assignment_params
    step self::Contract::Validate(key: :car_assignment)
    step Wrap ->(*, &block) { ActiveRecord::Base.transaction(&block) } {
      step :find_car
      step :find_order
      step :update_order_status_if_order_has_no_car
      step :assign_car_to_order
      step :send_car_assignment_email_to_user
      step :update_car_status_if_car_not_ordered
    }

    private

    def find_car(options, *)
      @car = Car.find(options['params']['car_assignment']['car_id'])
    end

    def find_order(options, *)
      @order = Order.find(options['params']['order_id'])
    end

    def add_order_id_to_car_assignment_params(_options, params:, **)
      params[:car_assignment].merge!(order_id: params[:order_id])
    end

    def update_order_status_if_order_has_no_car(_options, *)
      @order.update(order_status: 1)
    end

    def assign_car_to_order(*)
      @order.update(car_id: @car.id)
    end

    def send_car_assignment_email_to_user(_options, *)
      UserMailer.car_assignment_mail(@order.user, @car) if @order.user_id
    end

    def update_car_status_if_car_not_ordered(_options, *)
      @car.update(car_status: 1)
    end
  end
end
