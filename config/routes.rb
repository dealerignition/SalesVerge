DealerOnTheGo::Application.routes.draw do
  root :to => 'dashboard#index', :as => "dashboard"

  get "about" => "about#index"
  get "account_settings/account"
  get "account_settings/general"
  get "account_settings/dealer"
  get "account_settings/users"
  get "account_settings/users/create" => "users#new"
  post "account_settings/users/create" => "users#create", :as => "create_user"
  match "account_settings/users/:id/update" => "users#update", :as => "update_user"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "dealers#new", :as => "signup"

  resources :appointments
  resources :customers do
    resources :quotes
    resources :notes
    resources :sample_checkouts do
      get :check_in
    end
  end
  resources :dealers
  resources :quotes do
    resources :charges
    get :deliver_customer_mailer
    get :won
    get :lost
  end
  resources :samples
  resources :sample_checkouts do
    get :check_in
  end
  resources :sessions

  match ":controller(/:action(/:id))(.:format)"
end
