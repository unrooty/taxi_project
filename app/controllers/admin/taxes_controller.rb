module Admin
  #
  class TaxesController < AdminController

    def index
      result = Admin::Tax::Index.call(params, 'current_user'=>current_user)
      handle_successful(result)
    end

    def new
      result = Admin::Tax::Create::Present.call(params,
                                                'current_user' => current_user)
      handle_successful(result)
    end

    def create
      result = Admin::Tax::Create.call(params,
                                         'current_user' => current_user)
      handle_successful(result) do
        redirect_to admin_taxes_path, notice: t('tax_create',
                                                full_tax: @model.name)
      end

      handle_invalid(result) do
        render :new
      end
    end

    def edit
      result = Admin::Tax::Update::Present.call(params,
                                                'current_user' => current_user)
      handle_successful(result)
    end

    def update
      result = Admin::Tax::Update.call(params, 'current_user' => current_user)
      handle_successful(result) do
        redirect_to admin_taxes_path, notice: t('tax_update')
      end

      handle_invalid(result) do
        render :edit
      end
    end

    def destroy
      result = Admin::Tax::Delete.call(params, 'current_user' => current_user)
      handle_successful(result) do
        redirect_to admin_taxes_path, notice: t('tax_deleted')
      end
    end

  end
end
