Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :goals do
    resources :comments, only: [:create]
  end

  resources :comment

  root to: "users#index"

  post "cheer/:goal_id" => "goals#cheer", as: :cheer

end
