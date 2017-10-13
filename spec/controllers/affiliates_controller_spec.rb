require 'rails_helper'

module MyEngine
  class Engine < ::Rails::Engine
    isolate_namespace MyEngine
  end

  Engine.routes.draw do
    resources :affiliates, only: [:show] do
      get :random, on: :collection
    end
  end

  class AffiliatesController < ::ActionController::Base
    def random
      @random_affiliate = Affiliate.all.sample
      redirect_to affiliate_path(@random_affiliate)
    end

    def show
      @affiliate = Affiliate.find(params[:id])
      render text: @affiliate.name
    end
  end
end

RSpec.describe AffiliatesController, type: :controller do
  login_user

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
      expect(response.body).to eq ''
    end
  end
end

RSpec.describe MyEngine::AffiliatesController, type: :controller do
  routes { MyEngine::Engine.routes }

  it 'redirects to a random widget' do
    Affiliate.create!(name: 'Name 1', address: 'address 1')
    Affiliate.create!(name: 'Name 2', address: 'address 2')

    get :random
    expect(response).to redirect_to(assigns(:random_affiliate))
  end
end
