Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # namespace the controllers without affecting the URI
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :bucketlists do
      resources :items
    end
  end

  # post 'auth/login', to: 'authentication#authenticate'
  # post 'signup', to: 'users#create'
end