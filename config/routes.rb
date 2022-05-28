Rails.application.routes.draw do

  namespace :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
