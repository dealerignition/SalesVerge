DealerOnTheGo::Application.routes.draw do
  root :to => 'dashboard#index'

  get "about/index"
  get "account_settings/account"
  get "account_settings/dealer"
  get "account_settings/users"
  get "dashboard/index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "dealers#new", :as => "signup" 
  get "users/admin_create"

  resources :appointments
  resources :customers
  resources :dealers
  resources :quotes do
    resources :charges
  end
  resources :samples
  resources :sample_checkouts
  resources :sessions

  match ':controller(/:action(/:id))(.:format)'
end
