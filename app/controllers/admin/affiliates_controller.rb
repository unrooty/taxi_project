module Admin
  #
  class AffiliatesController < AdminController
    before_action :set_affiliate, only: %i[show edit update
                                           destroy affiliate_workers]

    def index
      @affiliates = Affiliate.all
    end

    def show
      @cars = @affiliate.cars
    end

    def new
      @affiliate = Affiliate.new
    end

    def edit; end

    def create
      @affiliate = Affiliate.new(affiliate_params)
      if @affiliate.save
        redirect_to admin_affiliates_path,
                    notice: t('affiliate_created',
                              affiliate_name: @affiliate.name)
      else
        render :new
      end
    end

    def update
      if @affiliate.update(affiliate_params)
        redirect_to admin_affiliates_path, notice: t('affiliate_updated')
      else
        render :edit
      end
    end

    def destroy
      @affiliate.destroy

      redirect_to admin_affiliates_path, notice: t('affiliate_deleted')
    end

    def affiliate_workers
      @workers = @affiliate.users.where.not(role: :client)
    end

    private

    def set_affiliate
      @affiliate = Affiliate.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_affiliates_path, notice: t('record_not_found')
    end

    def affiliate_params
      params.require(:affiliate).permit(:name, :address)
    end
  end
end
