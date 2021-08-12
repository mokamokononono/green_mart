Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "users/show" => "users#show"
  root to: "items#index"
  resources :items do
    resources :itemcomments, only: [:create]
    resources :orders, only: [:index, :create]
  end
  resources :contents do
    resources :contentcomments, only: [:create]
  end

  resources :users, only: [:show, :edit, :update]
end
