Rails.application.routes.draw do
  devise_for :users, :controllers => {
    sessions: 'user/sessions', registrations: 'user/registrations', passwords: 'user/passwords'
  }

  get "response_data", to: "response_data#show"
  post "webhook/:id/transactions", to: "webhook#transactions"

  resources :accounts, only: [:index, :create, :destroy, :update]
  resources :transactions, only: [:update]

  root to: "response_data#show"

  # debug ones
  get "webhook/:id/show", to: "webhook#show"
  get "sync_data", to: "response_data#sync"

end
