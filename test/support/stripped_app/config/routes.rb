# frozen_string_literal: true

Rails.application.routes.draw do
  resource :defaults, only: [:create]
  resource :configured, only: [:create], controller: "configured"
end
