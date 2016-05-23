Rails.application.routes.draw do
  # Post actions
  get  'blog/search/:query' => 'posts#search'
  post 'blog/search'        => 'posts#search_redirect'
  resources :posts, path: '/blog'

  # Tags
  get 'blog/tag/:tag' => 'posts#search_tags'

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
  root :to => redirect('/blog')

  # 404 all other attempted routes
  get '*path' => 'application#not_found'
end
