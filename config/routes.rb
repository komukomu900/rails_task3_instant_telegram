Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :destroy, :edit, :update] do
    collection do
      post :confirm
    end
    member do
      get :favorite
      get :post_index
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/inbox"
end