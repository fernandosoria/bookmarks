Bookmarks::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:update, :show]

  resources :bookmarks, only: [:index, :edit, :destroy, :update] do
    resources :likes, only: [:create, :destroy]
  end
  resources :tags, only: [:show]
  
  post :incoming, to: 'incoming#create'
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end