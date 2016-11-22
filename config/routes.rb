Rails.application.routes.draw do
  namespace :api do
    namespace :react do
      resources :articles, only: [:index, :show, :create, :update, :destroy]
      resources :article_images, only: [:index, :show, :create, :update, :destroy]
    end
  end
end