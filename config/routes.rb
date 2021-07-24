Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    patch '/users/withdraw' => 'users#withdraw'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'

  get 'my_page', to: 'users#show'
  get 'my_page/edit', to: 'users#edit'
  patch 'my_pages', to: 'users#update'
  put 'my_pages', to: 'users#update'

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
end
