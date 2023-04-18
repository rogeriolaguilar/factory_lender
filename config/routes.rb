# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clients, param: :external_id, only: %i[show create update destroy] do
    resources :invoices, param: :external_id
  end
  resources :invoices, only: [] do
    resources :purchases, param: :external_id, only: %i[index]
  end

  resources :purchases, param: :external_id, only: %i[show create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
