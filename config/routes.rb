Rails.application.routes.draw do
  root to: 'games#new'
  # get 'new', to: 'games#new'
  get 'score', to: 'games#score'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
