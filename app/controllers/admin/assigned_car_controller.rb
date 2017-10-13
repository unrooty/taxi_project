module Admin
  #
  class AssignedCarController < AdminController
    def new
      @assigned_car = AssignedCar.new
    end

    def create
      @assigned_car = AssignedCar.new(assigned_car_params.merge(order_id:
                                                                    params[
                                                                        :order_id
                                                                    ]))
      if @assigned_car.save == 0
        @assigned_car.send_letter
        redirect_to admin_orders_path, notice: t('car_assigned')
      elsif @assigned_car.save == 1
        redirect_to new_admin_order_assigned_car_path,
                    alert: t('car_assigned_error')
      elsif @assigned_car.save == 2
        redirect_to admin_orders_path, alert: t('car_already_assigned')
      else
        redirect_to admin_orders_path, alert: t('car_already_assigned')
      end
    end

    private

    def assigned_car_params
      params.require(:assigned_car).permit(:car_id)
    end
  end
end
