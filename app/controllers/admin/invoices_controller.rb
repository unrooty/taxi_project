module Admin
  #
  class InvoicesController < AdminController

    def new
      result = Admin::Invoice::Create::Present.call(params,
                                                    'current_user' => current_user)
      handle_successful(result)
    end

    def create
      result = Admin::Invoice::Create.call(params,
                                           'current_user' => current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('order_created')
      end

      handle_invalid(result) do
        render :new
      end
    end

    def edit
      result = Admin::Invoice::Update::Present.call(params,
                                                'current_user' => current_user)
      handle_successful(result)
    end

    def update
      result = Admin::Invoice::Update.call(params,
                                           'current_user' => current_user)
      handle_successful(result) do
        redirect_to admin_orders_path, notice: t('order_updated')
      end

      handle_invalid(result) do
        render :edit
      end
    end

    protected

    def not_found_redirect_path
      admin_orders_path
    end
  end
end
