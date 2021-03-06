Rails.application.routes.draw do
  # admin
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  root to: 'public/homes#top'
  
  namespace :admin do
  resources :genres, only: [:index,:create,:edit,:update]
  resources :items, only: [:index, :new, :show, :edit, :create, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  get 'homes/top'
  get 'orders/show'
  end
  
  #customers
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  namespace :public do
    post 'orders/confirm' => 'orders#confirm'
  resources :customers, only: [:show, :edit, :quit, :update]
  resources :orders, only: [:new, :index, :show, :update, :create] do
    collection do
      get :complete
    end
  
  end
  
  resources :items, only: [:index, :show, :update]
  resources :cart_items, only: [:index, :update, :create, :destroy] do
    collection do
    delete 'destroy_all'
  end
  end
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  get 'registrations/new'
  get 'homes/top'
  get 'homes/about'
  
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
