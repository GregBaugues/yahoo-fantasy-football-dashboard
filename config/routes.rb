YahooFantasyFootball::Application.routes.draw do
  root to: 'teams#index'

  resources :teams
  resources :players
  resources :articles

end
