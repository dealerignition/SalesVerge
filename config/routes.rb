SalesVerge::Application.routes.draw do
  
  get "about" => "about#index"
  get 'customers/getcsv' => 'customers#getcsv'
  put "app_requests/create" => "app_requests#create", :as => "create_app_requests"
  get "settings/account"
  get "settings/password"
  get "settings/general"
  get "settings/company"
  get "settings/users"
  get "settings/extras"
  match "settings/users/:id/update" => "users#update", :as => "update_user"
  post "close_tutorial" => "application#close_tutorial", :as => 'close_tutorial'
  get "dashboard/big_screen" => "dashboard#big_screen", :as => "big_screen"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "companies#new", :as => "signup"
  get "users/new/:invitation_token" => "users#new", :as => "new_user"
  post "users/create" => "users#create", :as => "create_user"
  put "users/detatch_avatar" => "users#detatch_avatar", :as => "user_detatch_avatar"
  put "users/:id/deactivate" => "users#deactivate", :as => "user_deactivate"
  put "users/:id/activate" => "users#activate", :as => "user_activate"
  put "users/:id/role" => "users#change_role"
  put "users/yes_receive_nightly_digest" => "users#yes_receive_nightly_digest"
  put "users/no_receive_nightly_digest" => "users#no_receive_nightly_digest"

  match '/login_as' => "sessions#login_as"
  match '/mobile_infographic' => "about#mobile_infographic"

  resource :settings do
    get :send_email_preview
  end

  resources :customers do
    post "create_customer_extension" => "customer_extensions#create"
    resources :quotes
    resources :notes
    resources :sample_checkouts do
      get :check_in
    end
  end

  resources :companies do
    put "detatch_logo", :as => "detatch_logo"
    put "set_wants_website_scraped", :as => "set_wants_website_scraped"
  end

  resources :company_users

  resources :quotes do
    resources :charges
    get :deliver_customer_mailer
    get :won
    get :lost
  end

  resources :samples
  resources :sample_checkout_sets do
    get :check_in
  end
  resources :invitations do
    put :accept
    put :reject
  end
  get "invitation/connect/:invitation_token" => "invitations#connect", :as => "invitation_connect"

  resources :sessions
  
  match '', to: 'about#salesverge', constraints: { subdomain: 'mk1' }
  match '', to: 'about#floorstoreonthego', constraints: { subdomain: 'mk2' }
  match '', to: 'about#salesups', constraints: { subdomain: 'mk3' }
  
  match "/admin" => "dashboard#admin"
  
  root :to => 'dashboard#index', :as => "dashboard"
  match ":controller(/:action(/:id))(.:format)"
end
