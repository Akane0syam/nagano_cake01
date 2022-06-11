Rails.application.routes.draw do
root to: 'public/homes#top'
  # admin
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:index,:create,:edit,:update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    patch '/admin/items/:id/edit', to: "admin/items#edit"
    get 'homes/top'
    get 'orders/show'
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end

  #customers
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  namespace :public do
    get 'registrations/new'
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/complete'
    get 'orders/index'
    get 'orders/show'
    get 'items/index'
    get 'items/show'
    get 'homes/top'
    get 'homes/about'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/quit'
    get 'cart_items/index'
    get 'addresses/index'
    get 'addresses/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
