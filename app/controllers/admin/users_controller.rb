module Admin
  #
  class UsersController < AdminController
    before_action :set_user, only: %i[edit update destroy show]

    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def show; end

    def edit; end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_user_path(@user.id), notice: t('user_created')
      else
        render :new
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user.id), notice: t('user_updated')
      else
        render :edit
      end
    end

    def destroy
      @user.destroy

      redirect_to admin_users_path, notice: t('user_deleted')
    end

    private

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_users_path, notice: t('record_not_found')
    end

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :phone,
                                   :email,
                                   :affiliate_id,
                                   :role,
                                   :language)
    end
  end
end
