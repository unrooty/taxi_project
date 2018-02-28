module Admin
  #
  class TaxesController < AdminController
    def index
      result = Admin::Tax::Index.call(params: params,
                                      current_user: current_user)
      handle_successful(result)
    end

    def new
      result = Admin::Tax::Create::Present.call(params: params,
                                                current_user: current_user)
      handle_successful(result)
    end

    def create
      result = Admin::Tax::Create.call(params: params,
                                       current_user: current_user)
      handle_successful(result) do
        redirect_to admin_taxes_path, notice: t('tax_create',
                                                full_tax: @model.name)
      end

      handle_invalid(result) do
        render :new
      end
    end

    def edit
      result = Admin::Tax::Update::Present.call(params: params,
                                                current_user: current_user)
      handle_successful(result)
    end

    def update
      result = Admin::Tax::Update.call(params: params,
                                       current_user: current_user)
      handle_successful(result) do
        redirect_to admin_taxes_path, notice: t('tax_update')
      end

      handle_invalid(result) do
        render :edit
      end
    end

    def destroy
      result = Admin::Tax::Delete.call(params: params,
                                       current_user: current_user)
      handle_successful(result) do
        return redirect_to admin_taxes_path, notice: t('tax_deleted')
      end
      redirect_to admin_default_tax_selection_path
    end

    def default_tax_selection
      result = Admin::Tax::SetDefault::Present.call(params: params,
                                                    current_user: current_user)
      handle_successful(result)
    end

    def set_default
      result = Admin::Tax::SetDefault.call(params: params,
                                           current_user: current_user)
      handle_successful(result) do
        return redirect_to admin_taxes_path, notice: t('default_tax_changed')
      end

      handle_invalid(result) do
        return render :default_tax_selection
      end
      redirect_to admin_taxes_path, notice: t('error')
    end
  end
end
