module Admin
  #
  class OrdersController < AdminController
    respond_to :js
    def index
      result = Admin::Order::Index.call(params: params,
                                        current_user: current_user)
      handle_successful(result)
    end

    def new
      result = Admin::Order::Create::Present.call(params: params,
                                                  current_user: current_user)
      handle_successful(result)
    end

    def create
      result = Admin::Order::Create.call(params: params,
                                         current_user: current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('order_created')
      end

      handle_invalid(result) do
        render :new
      end
    end

    def show
      result = Admin::Order::Show.call(params: params,
                                       current_user: current_user)
      handle_successful(result)
    end

    def edit
      result = Admin::Order::Update::Present.call(params: params,
                                                  current_user: current_user)
      handle_successful(result)
    end

    def update
      result = Admin::Order::Update.call(params: params,
                                         current_user: current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('order_updated')
      end

      handle_invalid(result) do
        render :edit
      end
    end

    def destroy
      result = Admin::Order::Delete.call(params: params,
                                         current_user: current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('order_destroyed')
      end
    end
  end
end
