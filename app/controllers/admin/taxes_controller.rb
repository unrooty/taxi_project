module Admin
  #
  class TaxesController < AdminController
    before_action :set_tax, only: %i[edit update destroy]

    def index
      @taxes = Tax.all
    end

    def new
      @tax = Tax.new
    end

    def edit; end

    def create
      @tax = Tax.new(tax_params)
      if @tax.save
        redirect_to admin_taxes_path, notice: t('tax_create', full_tax: @tax.name)
      else
        render :new
      end
    end

    def update
      if @tax.update(tax_params)
        redirect_to admin_taxes_path, notice: t('tax_update')
      else
        render :edit
      end
    end

    def destroy
      @tax.destroy

      redirect_to admin_taxes_path, notice: t('tax_deleted')
    end

    private

    def set_tax
      @tax = Tax.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_taxes_path, notice: t('record_not_found')
    end

    def tax_params
      params.require(:tax).permit(:name, :cost_per_km, :basic_cost)
    end
  end
end
