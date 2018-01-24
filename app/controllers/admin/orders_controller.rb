module Admin
  #
  class OrdersController < AdminController
    respond_to :js
    before_action do
      redirect_to root_path, notice: t('access_denied') if current_user.client?
    end

    def index
      run Admin::Order::Index, params,
          desired_phone: params[:desired_phone], namespace: [:admin]
    end

    def new
      run Admin::Order::Create::Present
    end

    def show
      run Admin::Order::Show
    end

    def edit
      run Admin::Order::Update::Present
    end

    def create
      run Admin::Order::Create do
        return redirect_to admin_orders_path, notice: t('order_created')
      end

      render :new
    end

    def update
      run Admin::Order::Update do
        return redirect_to admin_orders_path, notice: t('order_updated')
      end

      render :edit
    end

    def destroy
      run Admin::Order::Delete do
        return redirect_to admin_orders_path, notice: t('order_destroyed')
      end
    end

  end
end
