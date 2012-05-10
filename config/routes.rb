DealerOnTheGo::Application.routes.draw do
  root :to => 'dashboard#index', :as => "dashboard"

  get "about" => "about#index"
  get "account_settings/account"
  get "account_settings/password"
  get "account_settings/general"
  get "account_settings/dealer"
  get "account_settings/users"
  get "account_settings/extras"
  match "account_settings/users/:id/update" => "users#update", :as => "update_user"
  post "close_tutorial" => "application#close_tutorial", :as => 'close_tutorial'
  get "dashboard/big_screen" => "dashboard#big_screen", :as => "big_screen"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "dealers#new", :as => "signup"
  get "users/new/:invitation_token" => "users#new", :as => "new_user"
  post "users/create" => "users#create", :as => "create_user"
  put "users/detatch_avatar" => "users#detatch_avatar", :as => "user_detatch_avatar"

  resource :account_settings do
    get :send_email_preview
  end
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
