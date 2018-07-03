Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # namespace the controllers without affecting the URI
 
  namespace :v1 do
    resources :bucketlists do
      resources :items
    end
  end


  # post 'auth/login', to: 'authentication#authenticate'
  # post 'signup', to: 'users#create'
end
