# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'vehicles#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: %i[index show edit update]
  resources :vehicles, only: %i[index new create edit update destroy]
  resources :dealerships, only: %i[index new create edit update destroy]
end
