Rails.application.routes.draw do
  # Post actions
  get  'posts/search/:query' => 'posts#search'
  post 'posts/search'        => 'posts#search_redirect'
  resources :posts

  # Projects actions
  resources :projects

  # Bio page
  get 'bio' => 'bio#index'

  # Subscriber actions
  get 'subscribers/delete/:id' => 'subscribers#destroy', constraints: { id: /.+\..+/ }
  resources :subscribers, constraints: { id: /.+\..+/ }

  # Non-RSS redirect
  get 'feed' => 'posts#feed'

  # Default page
  root :to => redirect('/posts')

  # 404 all other attempted routes
  get '*path' => 'application#not_found'
end
