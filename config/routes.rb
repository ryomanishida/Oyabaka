Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  devise_scope :user do
    patch '/users/withdraw' => 'users#withdraw'
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

  resources :content_albums, only: [:new, :create]
  patch '/content_albums/:album_id', to: 'content_albums#update', as: 'content_album'
  get '/album/:album_id/content_albums_edit', to: 'content_albums#edit', as: 'edit_content_album'

  resources :albums, only: [:index, :show, :update, :destroy]

  resources :categories, only: [:show, :destroy]

end
