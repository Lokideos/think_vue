Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :staff do
    resources :staffs, only: :index
  end

  root to: 'staff/staffs#index'
end
