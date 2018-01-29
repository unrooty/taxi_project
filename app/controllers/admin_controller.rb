class AdminController < ApplicationController
  include Matcher
  layout 'admin'
  before_action :authenticate_user!
  before_action :redirect_client_to_root

  private

  def redirect_client_to_root
    redirect_back(fallback_location: root_path) if current_user.role == 'client'
  end
end
