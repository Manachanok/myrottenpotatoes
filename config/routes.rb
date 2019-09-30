# config/routes.rb
Myrottenpotatoes::Application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
  
  get  'auth/:provider/callback', to: 'sessions#create'
  get  'auth/:provider' => 'sessions#loginbefore'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/twitter' => 'login'
  get  'auth/facebook' => 'login'
  
  # Route that posts 'Search TMDb' form
  post '/movies/search_tmdb'
end