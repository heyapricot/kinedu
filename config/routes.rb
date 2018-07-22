Rails.application.routes.draw do
  resources :activity_logs, only: %i[index]

  namespace :api do
    resources :activities, only: %i[index]
    resources :babies, only: %i[index] do
      resources :activity_logs, only: %i[index]
    end
    resources :activity_logs, only: %i[create update]
  end

end
