Rails.application.routes.draw do
  resources :vehicles, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :dealerships, only: [:index, :new, :create, :edit, :update, :destroy]
end
