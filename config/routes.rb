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
      get 'users/test', to: 'users#test'
    end

  end

  get '/', to: 'static#home', as: 'home'

  get '/blog/:id', to: 'static#show'

  get '/profile', to: 'itinerary#showAll'
  get '/profile/:id', to: 'itinerary#edit'
  patch '/profile/:id', to: 'itinerary#update'
  post '/profile', to: 'itinerary#create'

  post '/activity', to: 'activity#create'
  patch '/activity', to: 'activity#update'
  delete '/activity', to: 'activity#destroy'

end
