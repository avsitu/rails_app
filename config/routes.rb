Rails.application.routes.draw do

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  resources :users do
    member do
      get :following, :followers, :liked_posts
    end
    collection do
      get :search
    end 
  end

  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  # get '/search_user', to: 'users#search'
  # patch '/users/:id/edit', to: 'users#update'
  # get 'users/:username', to: 'users#show', as: :username

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :microposts,          only: [:create, :destroy, :index]
  resources :relationships,       only: [:create, :destroy]
  resources :likes,               only: [:create, :destroy]

  
  post '/ppost', to: 'microposts#create_at_profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
