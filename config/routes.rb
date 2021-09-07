Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  namespace :api, { defaults: { format: :json } } do
    namespace :v1 do
      devise_for :users, :controllers => {
        registrations: "api/v1/registrations",
        confirmations: "api/v1/confirmations",
      }

      get 'users', to: 'users#index'
      # get 'users/:id', to: 'users#show'

      resources :regions do
        resources :products
      end

      resources :orders
    end
  end
end
