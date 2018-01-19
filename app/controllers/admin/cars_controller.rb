module Admin
  #
  class CarsController < AdminController

    def index
      run Car::Index
    end

    def new
      run Car::Create::Present
    end

    def show
      run Car::Show
    end

    def edit
      run Car::Update::Present
    end

    def create
      run Car::Create do
        return redirect_to admin_car_path(@model.id),
                           notice: t('car_create', car_model: @model.car_model,
                                                   car_brand: @model.brand)
      end
      render :new
    end

    def update
      run Car::Update do
        return redirect_to admin_car_path(@car.id), notice: t('car_update')
      end

      render :edit
    end

    def destroy
      run Car::Delete do
        redirect_to admin_cars_path, notice: t('car_deleted')
      end
    end

    private

    def car_params
      params.require(:car).permit(
        :brand,
        :car_model,
        :reg_number,
        :color,
        :style,
        :affiliate_id,
        :user_id
      )
    end
  end
end
