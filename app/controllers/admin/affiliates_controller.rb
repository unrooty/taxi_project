module Admin
  #
  class AffiliatesController < AdminController
    def index
      result = Admin::Affiliate::Index.call(params: params,
                                            current_user: current_user)
      handle_successful(result)
    end

    def new
      result = Admin::Affiliate::Create::Present.call(params: params,
                                                      current_user:
                                                          current_user)
      handle_successful(result)
    end

    def create
      result = Admin::Affiliate::Create.call(params: params,
                                             current_user: current_user)
      handle_successful(result) do
        redirect_to admin_affiliates_path,
                    notice: t('affiliate_created', affiliate_name: @model.name)
      end
      handle_invalid(result) do
        render :new
      end
    end

    def show
      result = Admin::Affiliate::Show.call(params: params,
                                           current_user: current_user)
      handle_successful(result)
    end

    def edit
      result = Admin::Affiliate::Update::Present.call(params: params,
                                                      current_user:
                                                          current_user)
      handle_successful(result)
    end

    def update
      result = Admin::Affiliate::Update.call(params: params,
                                             current_user: current_user)
      handle_successful(result) do
        redirect_to admin_affiliates_path,
                    notice: t('affiliate_created', affiliate_name: @model.name)
      end
      handle_invalid(result) do
        render :edit
      end
    end

    def destroy
      result = Admin::Affiliate::Delete.call(params: params,
                                             current_user: current_user)
      handle_successful(result) do
        redirect_to admin_affiliates_path,
                    notice: t('affiliate_deleted', affiliate_name: @model.name)
      end
    end

    def show_workers
      result = Admin::Affiliate::ShowWorkers.call(params: params,
                                                  current_user:
                                                               current_user)
      handle_successful(result) do
        @workers = result['workers']
      end
    end

    protected

    def not_found_redirect_path
      admin_affiliates_path
    end
  end
end
