Rails.application.routes.draw do
  resources :medical_appointments
  resources :patients
  resources :employees
  get '/calendar', to: 'medical_appointments#calendar'
  devise_for :users
  resources :users, path: 'system-users', only: [:index, :show, :edit, :update]
  root to: 'home#welcome'
end
