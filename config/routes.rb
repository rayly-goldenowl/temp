Rails.application.routes.draw do
  get 'todos/index'
  get 'todos/show'
  get 'todos/new'
  get 'todos/edit'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :api do
      devise_scope :user do
        post 'login', to: 'login#create', as: :user_login
        delete 'logout', to: 'login#destroy', as: :user_logout
        post 'signup', to: 'signup#create', as: :user_signup
    end
  end

  resources :todos

  resources :todos do
    patch 'update_status', on: :member
  end


  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root 'todos#index'
  get 'todos/index'


end
