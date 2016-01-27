Rails.application.routes.draw do
  # get 'bookmarks/show'
  #
  # get 'bookmarks/new'
  #
  # get 'bookmarks/edit'
  #


  devise_for :users, controllers: { confirmations: "users/confirmations", passwords: "users/passwords", registrations: "users/registrations", sessions: "users/sessions", unlocks: "users/unlocks"}

  resources :users do
    resources :topics, except: [:index, :show]
  end

  resources :topics , only: [:index, :show] do
    resources :bookmarks, except: [:index]
  end

  get 'welcome/index'

  get 'welcome/about'

  root 'topics#index'
end
