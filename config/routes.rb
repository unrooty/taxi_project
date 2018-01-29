Rails.application.routes.draw do

  devise_for :users
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
    get 'affiliate/:id/show_affiliate_workers',
        to: 'affiliates#show_affiliate_workers',
        as: :show_affiliate_workers
    resources :users
    resources :affiliates
    resources :taxes
    resources :cars
    resources :user, controller: 'admin/users'
    resources :order_statuses, only: [:index]
    resources :orders do
      resources :invoices
      resource :car_assignment, only: %i[new create] do
        get 'edit',
            to: 'car_assignments#edit',
            as: :edit
        post 'update',
             to: 'car_assignments#update',
             as: :update
        post 'driver_car_assignment',
             to: 'car_assignments#driver_car_assignment',
             as: :driver
      end
    end
  end
  match '*path', to: 'home#routing_error', via: %i[get post put delete]
end
