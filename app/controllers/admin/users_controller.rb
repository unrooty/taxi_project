module Admin
  #
  class UsersController < AdminController

    def index
      result = Admin::User::Index.call(params,
                                       'current_user'=>current_user)
      handle_successful(result)
    end

    def new
      result = Admin::User::Create::Present.call(params,
                                                 'current_user'=>current_user)
      handle_successful(result)
    end

    def create
      result = Admin::User::Create.call(params,
                                        'current_user'=>current_user)
      handle_successful(result) do
        redirect_to admin_users_path, notice: t('user_created')
      end
      handle_invalid(result) do
        render :new
      end
    end

    def show
      result = Admin::User::Show.call(params,
                                      'current_user'=>current_user)
      handle_successful(result)
    end

    def edit
      result = Admin::User::Update::Present.call(params,
                                                 'current_user'=>current_user)
      handle_successful(result)
    end

    def update
      result = Admin::User::Update.call(params,
                                        'current_user'=>current_user)
      handle_successful(result) do
        return redirect_to admin_user_path(@model.id), notice: t('user_updated')
      end

      render :edit
    end

    def destroy
      result = Admin::User::Delete.call(params,
                                        'current_user'=>current_user)
      handle_successful(result) do
        redirect_to admin_users_path, notice: t('user_deleted')
      end
    end

    def not_found_redirect_path
      admin_users_path
    end
  end
end
