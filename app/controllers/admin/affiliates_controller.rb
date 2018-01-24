module Admin
  #
  class AffiliatesController < AdminController

    def index
      run Admin::Affiliate::Index
    end

    def new
      run Admin::Affiliate::Create::Present
    end

    def create
      run Admin::Affiliate::Create do
        return redirect_to admin_affiliates_path,
                           notice: t('affiliate_created',
                                     affiliate_name: @model.name)
      end

      render :new
    end

    def show
      run Admin::Affiliate::Show
    end

    def edit
      run Admin::Affiliate::Update::Present
    end

    def update
      run Admin::Affiliate::Update do
        return redirect_to admin_affiliates_path,
                           notice: t('affiliate_updated')
      end

      render :edit
    end

    def destroy
      run Admin::Affiliate::Delete do
        redirect_to admin_affiliates_path, notice: t('affiliate_deleted')
      end
    end

    def show_affiliate_workers
      run Admin::Affiliate::ShowAffiliateWorkers
    end

  end
end
