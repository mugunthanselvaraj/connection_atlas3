Rails.application.routes.draw do
  mount Rswag::Api::Engine => "/api-docs"
  mount Rswag::Ui::Engine => "/api-docs"
  devise_for :users, controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }
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
          get :list_roles
          patch :update_roles
        end
      end
    end
  end
end
