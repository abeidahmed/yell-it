Rails.application.routes.draw do
  mount StripeEvent::Engine, at: "/stripe/webhooks"

  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]
  root "static_pages#home"

  namespace :app do
    resources :projects, only: %i[show] do
      resources :labels, only: %i[index]
      resources :subscriptions, only: %i[new create]
    end

    resource :confirm_subscription, only: %i[show], module: :subscriptions
  end
end
