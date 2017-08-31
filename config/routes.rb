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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
