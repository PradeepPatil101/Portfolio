Rails.application.routes.draw do
  # Basic routes
  get 'home/index'
  root 'home#index'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  get 'signup', to: "passengers#new", as: 'signup'
  get 'trains/:train_id/review', to: 'reviews#new', as: 'new_train_review'
  # Admin search
  get 'admins/passenger_search', to: 'admins#passenger_search', as: 'passenger_search'
  post 'admins/search_results', to: 'admins#search_results', as: 'search_results'
  # Purchase for other passenger
  get 'trains/:id/purchase_for_another_passenger', to: 'tickets#new_for_another', as: 'purchase_for_another_passenger'
  post 'trains/:id/confirm_purchase_for_another', to: 'tickets#confirm_purchase_for_another', as: 'confirm_purchase_for_another'


  # Resource routes
  resources :sessions, only: [:new, :create, :destroy]
  resources :passengers
  resources :tickets
  resources :trains
  resources :admins

  resources :reviews do
    collection do
      get 'manage_reviews'
      get 'eligible_trains'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Redirect for any incorrect route a user might enter
  match "*path", to: redirect('/'), via: :all
end
