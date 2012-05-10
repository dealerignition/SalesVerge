DealerOnTheGo::Application.routes.draw do
  root :to => 'dashboard#index', :as => "dashboard"

  get "about" => "about#index"
  match "account_settings/users/:id/update" => "users#update", :as => "update_user"
  get "dashboard/big_screen" => "dashboard#big_screen", :as => "big_screen"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "dealers#new", :as => "signup"
  get "users/new/:invitation_token" => "users#new", :as => "new_user"
  post "users/create" => "users#create", :as => "create_user"
  put "users/detatch_avatar" => "users#detatch_avatar", :as => "user_detatch_avatar"

  resources :appointments
  resources :customers do
    resources :quotes
    resources :notes
    resources :sample_checkouts do
      get :check_in
    end
  end
  resources :dealers do
    put "detatch_logo", :as => "detatch_logo"
  end
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
  resources :invitations
  resources :sessions

  match ":controller(/:action(/:id))(.:format)"
end
