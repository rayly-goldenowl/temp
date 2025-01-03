Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :user do
      devise_scope :user do
        post 'login', to: 'login#create', as: :user_login
        delete 'logout', to: 'login#destroy', as: :user_logout
        post 'signup', to: 'signup#create', as: :user_signup
      end
    end
  end

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root 'pages#index'
  get 'pages/index'


end

# Rails.application.routes.draw do
#   root 'pages#index'
#   get 'pages/index'
# end
