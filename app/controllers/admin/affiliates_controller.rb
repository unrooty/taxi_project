module Admin
  #
  class AffiliatesController < AdminController

    def index
      run Affiliate::Index
    end

    def new
      run Affiliate::Create::Present
    end

    def create
      run Affiliate::Create do
        return redirect_to admin_affiliates_path,
                           notice: t('affiliate_created',
                                     affiliate_name: @model.name)
      end

      render :new
    end

    def show
      run Affiliate::Show
    end

    def edit
      run Affiliate::Update::Present
    end

    def update
      run Affiliate::Update do
        return redirect_to admin_affiliates_path,
                           notice: t('affiliate_updated')
      end

      render :edit
    end

    def destroy
      run Affiliate::Delete do
        redirect_to admin_affiliates_path, notice: t('affiliate_deleted')
      end
    end

    def show_affiliate_workers
      run Affiliate::ShowAffiliateWorkers
    end

    private

    def affiliate_params
      params.require(:affiliate).permit(:name, :address)
    end
  end
end
