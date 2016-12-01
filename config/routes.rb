Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    namespace :react do
      resources :articles, only: [:index, :show, :create, :update, :destroy]
      resources :article_images, only: [:index, :create, :destroy]
      resources :sessions, only: [:create] do
        delete 'destroy', on: :collection
      end
    end
  end
end