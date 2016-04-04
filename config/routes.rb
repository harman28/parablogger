Rails.application.routes.draw do

  resources :posts, only: [:index, :show]
  post "posts" 									=> "posts#new"
  post "comments"								=> "comments#new"
end
