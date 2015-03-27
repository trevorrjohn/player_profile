Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :players, only: :index
    end
  end
end
