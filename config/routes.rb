Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    patch '/users/withdraw' => 'users#withdraw'
    patch '/adminwithdraw' => 'users#adminwithdraw'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/home/change_language/:language" => "homes#change_language"
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'

  resources :users, only: [:show, :update]
  get 'user/:id/contents', to: 'users#contents', as: 'user_contents'
  get 'user/likes', to: 'users#likes', as: 'user_likes'

  resources :contents, except: [:index] do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
    get :search, on: :collection
  end


  namespace :admin do
    resources :users
  end

  namespace :admin do
    resources :contents
  end

  resources :relationships, only: [:create, :destroy]

  resources :content_albums, only: [:new, :create, :edit, :update]


  resources :albums, only: [:index, :show, :update, :destroy]

  resources :categories, only: [:show]

end
