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

  end

  get '/', to: 'static#index'

  get '/blog/:id', to: 'static#show'

  get '/profile', to: 'itinerary#index'
  get '/profile/:id', to: 'itinerary#show'
  patch '/profile/:id', to: 'itinerary#update'
  post '/profile', to: 'itinerary#create'

  post '/activity', to: 'activity#create'
  patch '/activity', to: 'activity#update'
  delete '/activity', to: 'activity#destroy'

end
