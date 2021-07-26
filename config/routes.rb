Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    patch '/users/withdraw' => 'users#withdraw'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'

  resources :users, only: [:show, :edit, :update] do
    member do
     get :followings
    end
  end
  get 'user/:id/contents', to: 'users#contents', as: 'user_contents'

  resources :contents do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end


  namespace :admin do
    resources :users
  end

  namespace :admin do
    resources :contents
  end

  resources :relationships, only: [:create, :destroy]


end
