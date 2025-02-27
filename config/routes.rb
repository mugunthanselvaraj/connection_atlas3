Rails.application.routes.draw do
  devise_for :users, controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # /api/v1/events
  # /api/v1/events
  # /api/v1/events/:id
  namespace :api do
    namespace :v1 do
      resources :events do
        collection do
          get :active
          get :upcoming
          get :past
          get :active_upcoming
        end
        member do
          post :add_images
          delete :remove_image
        end
      end
      resources :users, only: [:index, :show, :update] do
        member do
          patch :deactivate
          post :upload_profile_picture
        end
      end
    end
  end
end
