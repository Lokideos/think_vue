Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :api do
    namespace :v1 do
      resources :users, shallow: true, only: %i[] do
        post :token_login, on: :collection
      end
    end
  end

  namespace :staff do
    resources :staffs, only: :index do
      get :user_data, on: :collection
    end
  end

  namespace :client do
    resources :clients, only: :index
  end

  root to: 'staff/staffs#index'
end
