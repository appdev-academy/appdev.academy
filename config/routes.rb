Rails.application.routes.draw do
  resources :articles, only: [:index, :show], param: :slug
  
  namespace :api, constraints: { format: :json } do
    namespace :react do
      resources :articles, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
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
    end
  end
end