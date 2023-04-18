# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clients, param: :external_id, only: %i[show create update destroy] do
    resources :invoices, param: :external_id
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
