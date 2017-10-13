Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard/index'
  end

  devise_for :users
  get 'orders/send_orders_mail',
      to: 'orders#send_orders_mail',
      as: :send_orders_mail
  get 'orders/pdf_orders', to: 'orders#pdf_orders', as: :pdf_orders
  get 'feedback', to: 'home#feedback_mail', as: :feedback
  post '', to: 'home#feedback_mail', as: '/'
  root to: 'home#index'
  get '/about', to: 'home#about', as: :about
  resources :affiliates, only: %i[show index]
  resources :orders

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    get 'affiliate/:id/affiliate_workers',
        to: 'affiliates#affiliate_workers',
        as: :affiliate_workers
    resources :users
    resources :affiliates
    resources :taxes
    resources :cars
    resources :user, controller: 'admin/users'
    resources :invoice_statuses, only: [:index]
    resources :order_statuses, only: [:index]
    resources :orders do
      resources :invoices
      resources :billing, only: %i[new create edit update]
      resources :assigned_car, only: %i[new create]
    end
  end
  match '*path', to: 'home#routing_error', via: %i[get post put delete]
end
