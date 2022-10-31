Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:sign_up,:sign_in] do
        collection do
          post 'sign_up', to: 'users#sign_up'
          post 'sign_in', to: 'users#sign_in'
        end
      end
    end
  end
end
