Bookmarks::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  post :incoming, to: 'incoming#create'
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end