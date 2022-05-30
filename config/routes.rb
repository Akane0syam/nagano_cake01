Rails.application.routes.draw do

  devise_for :admins

  namespace :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'

    resources :items
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
