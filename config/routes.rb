Rails.application.routes.draw do
  get '/admin', to: 'admin#index'
  get '/admin/*path', to: 'admin#index'
  
  # Static pages
  root 'pages#home'
  get '/about', to: 'pages#about'
  get '/contacts', to: 'pages#contacts'
  get '/guides', to: 'pages#guides'
  get '/open-source', to: 'pages#open_source'
  get '/services', to: 'pages#services'
  get '/request-estimate', to: 'estimate_requests#new'
  
  # Blog
  resources :articles, only: [:index, :show], param: :slug
  get '/articles/tag/:tag_slug', to: 'articles#taged_index', as: 'articles_tag'
  
  # Estimate request
  resources :estimate_requests, only: [:create]
  
  # RSS feed
  get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  
  # Portfolio with projects
  namespace :portfolio do
    root to: 'projects#index'
    resources :projects, only: [:show], param: :slug
  end
  get '/portfolio/projects/tags/:tag_slug', to: 'portfolio/projects#taged_index', as: 'projects_tag'
  
  resources :screencasts, only: [:index, :show], param: :slug do
    resources :lessons, only: [:show], param: :slug
  end
  
  # JSON API
  namespace :api, shallow: true, constraints: { format: :json } do
    namespace :react do
      resources :articles, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
      end
      
      resources :dashboards, only: [] do
        get :main, on: :collection
      end
      
      resources :employees, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
      end
      
      resources :estimate_requests, only: [:index, :show]
      
      resources :gallery_images, only: [:destroy] do
        collection do
          post :sort
        end
      end
      
      resources :images, only: [:index, :create, :destroy]
      
      resources :pages, only: [:index, :show, :update], param: :slug
      
      resources :projects, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
        
        resources :gallery_images, only: [:index, :create]
      end
      
      resources :sessions, only: [:create] do
        delete 'destroy', on: :collection
      end
      
      resources :tags, only: [:index, :show, :create, :update, :destroy]
      
      resources :testimonials, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
      end
      
      resources :topics, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
        
        resources :screencasts, only: [:index, :show, :create, :update, :destroy] do
          post :publish, on: :member
          post :hide, on: :member
          post :sort, on: :collection
          
          resources :lessons, only: [:index, :show, :create, :update, :destroy] do
            post :publish, on: :member
            post :hide, on: :member
            post :sort, on: :collection
          end
        end
      end
    end
  end
end
