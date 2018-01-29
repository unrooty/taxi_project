class AffiliatesController < ApplicationController

  def index
    run Affiliate::Index
  end

  def show
    run Affiliate::Show
  end
end
