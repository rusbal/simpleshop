Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  namespace :api, { defaults: { format: :json } } do
    namespace :v1 do
      devise_for :users, :controllers => {
        registrations: "api/v1/registrations",
        confirmations: "api/v1/confirmations",
      }

      resources :regions
    end
  end
end
