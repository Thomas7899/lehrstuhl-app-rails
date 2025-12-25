# config/routes.rb
Rails.application.routes.draw do
  # ===== API Routes für Vue.js Frontend =====
  namespace :api do
    namespace :v1 do
      resources :students
      resources :seminare
      resources :abschlussarbeiten
      get 'dashboard/stats', to: 'dashboard#stats'
      
      # Chatbot API
      get 'chatbot/messages', to: 'chatbot#messages'
      post 'chatbot', to: 'chatbot#create'
      delete 'chatbot/clear', to: 'chatbot#clear'
    end
  end

  # ===== Legacy HTML Routes (für bestehende Rails Views) =====
  resources :abstrakte_abschlussarbeits
  get "registrations/new"
  get "registrations/create"
  resource :registration, only: %i[new create]
  resource :session
  resources :passwords, param: :token
  resources :konkrete_abschlussarbeits

  # KORRIGIERT: Nur Resource-Route für Chat Messages
  resources :chat_messages, only: [ :index, :create, :show ]

  resources :students

  resources :texts, only: [] do
    collection do
      get :analyze
      post :analyze
    end
  end

  # Chatbot Routes
  get "chatbot", to: "chatbot#index"
  post "chatbot", to: "chatbot#create"
  delete "chatbot/clear_history", to: "chatbot#clear_history"

  # Debug Route
  post "test", to: "simple_test#test"

  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
