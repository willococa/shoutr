Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root  to: "dashboards#show", as: :signed_in_root   
  end
  root to: "homes#show"
  resources :shouts, only: [:create, :show] do
    #here a member route is created because it feels more like an acttion of a shout
    #than a nested resource 
    #so it will create aroute like like_shout_path
    #instead of shout_like_path
    member do
      post  "like"=>"likes#create"
      delete  "unlike"=>"likes#destroy"
    end
  end
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]

  resources :users, only: [:create, :show] do
    resources :followers, only: [:index]
    member do
      post "follow" => "followed_users#create"
      delete "unfollow" => "followed_users#destroy"
    end
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
