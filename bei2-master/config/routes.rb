Rails.application.routes.draw do

  devise_for :users
  get 'ratings/index'

  get 'ratings/show'

  get 'ratings/new'
  resources :ingredients
  root "ingredients#index"

  get 'ratings_controller/index'

  get 'ratings_controller/show'

  get 'ratings_controller/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'recipes/list'
  get 'recipes/search'

  get 'recipes/foods'
  get 'recipes/findrecipes'
  get 'recipes/recipeinfo'
  get 'recipes/steps'
  get 'recipes/getsteps'
  resources :recipes
  resources :ratings
end
