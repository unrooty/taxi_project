module Admin
  #
  class AffiliatesController < AdminController
    def index
      result = Admin::Affiliate::Index.call(params,
                                            'current_user' => current_user)
      match(%w[success unauthorized]).call(result) do |m|
        m.success { @model = result['model'] }
        m.unauthorized { redirect_to admin_orders_path }
      end
    end

    def new
      result = Admin::Affiliate::Create::Present.call(params,
                                                      'current_user' =>
                                                          current_user)
      match(%w[success unauthorized not_found]).call(result) do |m|
        m.success do
          @form = result['contract.default']
          @model = result['model']
        end
        m.unauthorized { redirect_to admin_orders_path }
        m.not_found { redirect_to admin_orders_path, notice: t('record_not_found') }
      end
    end

    def create
      result = Admin::Affiliate::Create.call(params,
                                             'current_user' => current_user)
      match(%w[success invalid]).call(result) do |m|
        m.success { redirect_to admin_affiliate_path(result['model'].id) }
        m.invalid do
          @form = result['contract.default']
          @model = result['model']
          render :new
        end
      end
    end

    def show
      result = Admin::Affiliate::Show.call(params,
                                           'current_user' => current_user)
      match(%w[success unauthorized not_found]).call(result) do |m|
        m.success { @model = result['model'] }
        m.unauthorized { redirect_to admin_orders_path }
        m.not_found do
          redirect_to admin_orders_path,
                      notice: t('record_not_found') end
      end
    end

    def edit
      result = Admin::Affiliate::Update::Present.call(params,
                                                      'current_user' =>
                                                          current_user)
      match(%w[success unauthorized not_found]).call(result) do |m|
        m.success do
          @form = result['contract.default']
          @model = result['model']
        end
        m.unauthorized { redirect_to admin_orders_path }
        m.not_found { redirect_to admin_orders_path, notice: t('record_not_found') }
      end
    end

    def update
      result = Admin::Affiliate::Update.call(params,
                                             'current_user' => current_user)
      match(%w[success invalid]).call(result) do |m|
        m.success { redirect_to admin_affiliate_path(result['model'].id) }
        m.invalid do
          @form = result['contract.default']
          @model = result['model']
          render :new
        end
      end
    end

    def destroy
      result = Admin::Affiliate::Delete.call(params,
                                             'current_user' => current_user)
      match(%w[success unauthorized not_found]).call(result) do |m|
        m.success { redirect_to admin_affiliates_path }
        m.unauthorized { redirect_to admin_orders_path }
        m.not_found do
          redirect_to admin_orders_path,
                      notice: t('record_not_found') end
      end
    end

    def show_affiliate_workers
      result = Admin::Affiliate::ShowAffiliateWorkers.call(params,
                                                           'current_user' =>
                                                               current_user)
      match(%w[success unauthorized not_found]).call(result) do |m|
        m.success { @model = result['model'] }
        m.unauthorized { redirect_to admin_orders_path }
        m.not_found do
          redirect_to admin_orders_path,
                      notice: t('record_not_found') end
      end
    end
  end
end
