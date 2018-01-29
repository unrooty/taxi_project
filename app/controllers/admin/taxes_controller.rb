module Admin
  #
  class TaxesController < AdminController

    def index
      run Admin::Tax::Index
    end

    def new
      run Admin::Tax::Create::Present
    end

    def edit
      run Admin::Tax::Update::Present
    end

    def create
      run Admin::Tax::Create do
        return redirect_to admin_taxes_path, notice: t('tax_create',
                                                full_tax: @model.name)
      end
      render :new
    end

    def update
      run Admin::Tax::Update do
        return redirect_to admin_taxes_path, notice: t('tax_update')
      end
      render :edit
    end

    def destroy
      run Admin::Tax::Delete do
        redirect_to admin_taxes_path, notice: t('tax_deleted')
      end
    end

  end
end
