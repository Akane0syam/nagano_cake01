Rails.application.routes.draw do

  namespace :public do
    get 'registrations/new'
  end
  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/complete'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/quit'
  end
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
  end
  namespace :admin do
    get 'sessions/new'
  end
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
