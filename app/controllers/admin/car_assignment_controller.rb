module Admin
  #
  class CarAssignmentController < AdminController
    def new
      run Admin::CarAssignment::Create::Present
    end

    def create
      run Admin::CarAssignment::Create do
        return redirect_to admin_orders_path, notice: t('car_assigned')
      end
      flash.now[:alert] = "Car can't be assigned."
      render :new
    end

    def edit
      run Admin::CarAssignment::Update::Present
    end

    def update
      run Admin::CarAssignment::Update do
        return redirect_to admin_orders_path, notice: t('car_reassigned')
      end
      flash.now[:alert] = "Car can't be assigned."
      render :edit
    end
  end
end
