Rails.application.routes.draw do

  root to: "categories#index"

  resources :groups do 
    resources :memberships, only: [:new, :create, :update, :destroy] do
      member do
        get :promote
        get :demote
      end
    end
  end

  resources :users, except: [:new, :create]

  resources :documents, except: [:index] do
    member do 
      get :download
    end
    collection do
      get :search
      post :search
    end

    resources :revisions, only: [:new, :create, :destroy] do
      member do
        get :download
      end
    end
  end 

  resources :categories

  get '/auth/:provider/callback', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

end