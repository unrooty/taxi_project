class ApplicationController < ActionController::Base
  include Pundit
  include ResultHandler
  protect_from_forgery
  layout 'page'
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name
                                                         last_name
                                                         role
                                                         phone
                                                         language])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name
                                                                last_name
                                                                role
                                                                phone
                                                                affiliate_id
                                                                language
                                                                avatar
                                                                avatar_cache
                                                                remove_avatar])
  end

  def set_locale
    user_signed_in? && current_user.language == 'English' ? I18n.locale = :en : I18n.locale = :ru
  end
end
