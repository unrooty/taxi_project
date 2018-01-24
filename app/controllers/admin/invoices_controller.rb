module Admin
  #
  class InvoicesController < AdminController

    def new
      run Admin::Invoice::Create::Present
    end

    def create
      p params
      run Admin::Invoice::Create do
        return redirect_to admin_orders_path, notice: t('invoice_created')
      end

      render :new
    end

    def edit
      run Admin::Invoice::Update::Present
    end

    def update
      run Admin::Invoice::Update do
        return redirect_to admin_orders_path, notice: t('invoice_updated')
      end

      render :edit
    end
    
  end
end
