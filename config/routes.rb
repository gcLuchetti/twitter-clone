# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :tweets, only: :create

  root 'home#index'
end
