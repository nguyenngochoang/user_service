Rails.application.routes.draw do
  resources :users, only: %i[create] do
    collection do
      get :info
    end
  end
end
