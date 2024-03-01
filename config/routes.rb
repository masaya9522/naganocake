Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

    namespace :admin do
      root to: 'homes#top'
      resources :items, only: [:index, :new, :create, :update, :edit, :show]
      resources :customers, only: [:index, :show, :edit, :update]
      resources :orders, only: [:show, :update]
      resources :order_items, only: [:update]
    end

    scope module: :public do
      root to: 'homes#top'
      get 'home/about', to: 'homes#about', as: :about

      get 'customers/my_page', to: 'customers#show', as: :my_page
      get 'customers/information/edit',to: 'customers#edit', as: :edit
      patch 'customers/information', to: 'customers#update'
      get 'customers/confirm_withdraw', to: 'customers#confirm_withdraw', as: :confirm_withdraw
      patch 'customer/withdraw', to: 'customers#withdraw'

      resources :items, only: [:index, :show]
      resources :addresses, only: [:index, :create, :update, :destroy, :edit]
      resources :cart_items, only: [:create, :index, :update, :destroy]
      delete '/cart_items', to: 'cart_items#destroy_all'
      get '/orders/complete', to: 'orders#complete'
      resources :orders, only: [:new, :index, :show]
      post 'orders/confirm_order', to: 'orders#confirm_order', as: :confirm_order
      post '/orders', to: 'orders#create'
    end




# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
