module Admin
  #
  class UsersController < AdminController

    def index
      run Admin::User::Index
    end

    def new
      run Admin::User::Create::Present
    end

    def show
      run Admin::User::Show
    end

    def edit
      run Admin::User::Update::Present
    end

    def create
      run Admin::User::Create do
        return redirect_to admin_users_path, notice: t('user_created')
      end

      render :new
    end

    def update
      run Admin::User::Update do
        return redirect_to admin_user_path(@model.id), notice: t('user_updated')
      end

      render :edit
    end

    def destroy
      run Admin::User::Delete do
        redirect_to admin_users_path, notice: t('user_deleted')
      end
    end

  end
end
