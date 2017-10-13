class AffiliatesController < ApplicationController
  before_action :set_affiliate, only: :show

  def index
    @affiliates = Affiliate.all
  end

  def show
    @cars = @affiliate.cars
  end

  private

  def set_affiliate
    @affiliate = Affiliate.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: t('record_not_found')
  end
end
