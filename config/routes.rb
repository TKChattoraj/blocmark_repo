Rails.application.routes.draw do

  post :incoming, to: 'incoming#create'


  devise_for :users, controllers: { confirmations: "users/confirmations", passwords: "users/passwords", registrations: "users/registrations", sessions: "users/sessions", unlocks: "users/unlocks"}

  resources :users do
    resources :topics, except: [:index, :show]
  end

  resources :topics, only: [:index, :show] do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks, except: [:index] do
    resources :likes, only: [:index, :create, :destroy]
  end

  get 'likes/index'

  get 'welcome/index'

  get 'welcome/about'

  root 'topics#index'
end
