# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  devise_for :users
  resources :vehicles, only: %i[index new create edit update destroy]
  resources :dealerships, only: %i[index new create edit update destroy]
end
