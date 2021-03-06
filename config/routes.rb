Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users,
  only: :registrations,
  controllers: {
   registrations: 'users/registrations'
 }
  namespace :api do

    namespace :v1 do
      get 'users/sync', to: 'users#sync'
    end

    namespace :static do
      get '/something', to: 'test#test'
    end

  end

  get '/', to: 'static#index'

  get '/blog/:id', to: 'static#show'

  get '/user/:id', to: 'static#findUser'

  get '/currentuser', to: 'currentuser#show'

  get '/profile', to: 'itinerary#index'
  get '/profile/:id', to: 'itinerary#show'
  patch '/profile/:id', to: 'itinerary#update'
  post '/profile', to: 'itinerary#create'
  delete '/profile/:id', to: 'itinerary#destroy'

  get '/activity/:itinerary_id/:day', to: 'activity#fetchDay'

  post '/activity', to: 'activity#create'
  patch '/activity', to: 'activity#update'
  delete '/activity', to: 'activity#destroy'

  post '/photo', to: 'photo#create'
  patch '/photo', to: 'photo#update'
  delete '/photo', to: 'photo#destroy'
end
