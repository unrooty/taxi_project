class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  load_and_authorize_resource
end
