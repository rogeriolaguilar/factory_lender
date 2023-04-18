# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invoices, only: [:show, :create, :update, :destroy]
  resources :clients, param: :external_id, only: [:show, :create, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
