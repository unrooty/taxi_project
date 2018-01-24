module Admin
  #
  class CarAssignmentController < AdminController
    def new
      @car_assignment = AssignedCar.new
    end

    def create
      @car_assignment = AssignedCar.new(car_assignment_params.merge(order_id:
                                                                    params[
                                                                        :order_id
                                                                    ]))
      if @car_assignment.save == 0
        @car_assignment.send_letter
        redirect_to admin_orders_path, notice: t('car_assigned')
      elsif @car_assignment.save == 1
        redirect_to new_admin_order_car_assignment_path,
                    alert: t('car_assigned_error')
      elsif @car_assignment.save == 2
        redirect_to admin_orders_path, alert: t('car_already_assigned')
      else
        redirect_to admin_orders_path, alert: t('car_already_assigned')
      end
    end

    private

    def car_assignment_params
      params.require(:assigned_car).permit(:car_id)
    end
  end
end
