Rails.application.routes.draw do
  root to: "pages#home"
  get 'users/profile', as: 'user_root'
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users do
    resources :blogs do
      resources :posts
    end
  end
end
