Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_closed', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :styles
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only: [:index, :show]
  resource :session, only: [:new, :create, :destroy]
  root 'breweries#index'
  #get 'ratings',  to: 'ratings#index'
  #get 'ratings/new', to: 'ratings#new'
  #post 'ratings', to: 'ratings#create'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  post 'places', to: 'places#search'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'

  get 'auth/:provider/callback', to: 'sessions#create_oauth'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
