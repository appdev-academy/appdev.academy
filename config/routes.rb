Rails.application.routes.draw do
  # Static pages
  root 'pages#home'
  get '/about', to: 'pages#about'
  get '/contacts', to: 'pages#contacts'
  get '/guides', to: 'pages#guides'
  get '/open-source', to: 'pages#open_source'
  get '/screencasts', to: 'pages#screencasts'
  
  # Blog
  resources :articles, only: [:index, :show], param: :slug
  
  # RSS feed
  get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  
  # Portfolio with projects
  namespace :portfolio do
    root to: 'projects#index'
    resources :projects, only: [:show], param: :slug
  end
  
  # JSON API
  namespace :api, constraints: { format: :json } do
    namespace :react do
      resources :articles, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
      end
      resources :dashboards, only: [] do
        get :main, on: :collection
      end
      resources :images, only: [:index, :create, :destroy]
      resources :pages, only: [:index, :show, :update], param: :slug
      resources :projects, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
      end
      resources :sessions, only: [:create] do
        delete 'destroy', on: :collection
      end
      resources :topics, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
      end
    end
  end
end
