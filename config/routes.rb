Rails.application.routes.draw do
  resources :rentals do
    collection do
      post 'import'
    end
  end
  resources :leases do
    collection { post :import }
  end
  resources :sales
  resources :statuses
  resources :deductables
  resources :banks
  resources :originators
  resources :attorneys
  resources :agents do
    collection do
      post 'import'
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'application#index'
end
