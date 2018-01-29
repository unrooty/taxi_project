module Admin
  #
  class CarsController < AdminController

    def index
      run Admin::Car::Index
    end

    def new
      run Admin::Car::Create::Present
    end

    def show
      run Admin::Car::Show
    end

    def edit
      run Admin::Car::Update::Present
    end

    def create
      run Admin::Car::Create do
        return redirect_to admin_car_path(@model.id),
                           notice: t('car_create', car_model: @model.car_model,
                                                   car_brand: @model.brand)
      end
      render :new
    end

    def update
      run Admin::Car::Update do
        return redirect_to admin_car_path(@car.id), notice: t('car_update')
      end

      render :edit
    end

    def destroy
      run Admin::Car::Delete do
        redirect_to admin_cars_path, notice: t('car_deleted')
      end
    end

  end
end
