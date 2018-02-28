Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'orders/send_email_with_orders',
      to: 'orders#send_email_with_orders',
      as: :send_orders_mail
  get 'orders/generate_orders_pdf',
      to: 'orders#generate_orders_pdf',
      as: :generate_orders_pdf
  get 'feedback', to: 'home#feedback_mail', as: :feedback
  post '', to: 'home#feedback_mail', as: '/'
  root to: 'home#index'
  get '/about', to: 'home#about', as: :about
  resources :affiliates, only: %i[show index]
  resources :orders

  namespace :admin do
    get 'dashboard/index'
    get '', to: 'dashboard#index', as: '/'
    resources :users
    resources :affiliates do
      get 'show_workers',
          to: 'affiliates#show_workers',
          as: :show_workers
    end
    resources :taxes, except: :show
    get 'taxes/default_tax_selection', to: 'taxes#default_tax_selection',
                                       as: :default_tax_selection
    post 'taxes/set_default', to: 'taxes#set_default',
                              as: :set_default_tax_post
    resources :cars
    resources :user, controller: 'admin/users'
    resources :order_statuses, only: [:index]
    resources :orders do
      resources :invoices, only: %i[new create edit update]
      resource :car_assignment, only: %i[new create edit update]
    end
  end
  match '*path', to: 'home#routing_error', via: %i[get post put delete]
end
