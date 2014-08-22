Bookmarks::Application.routes.draw do
  devise_for :users

  post :incoming, to: 'incoming#create'
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end