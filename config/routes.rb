Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  root to: 'pages#home'

  resources :users, only: :index

  resources :links, only: [ :index, :new, :create, :destroy ]

  resources :project_chats, only: :show do
    resources :messages, only: :create
  end

  resources :chatrooms, only: :show do
    resources :direct_messages, only: :create
  end

  resources :projects, concerns: :paginatable do
    resources :collaborations
    resources :milestones
    resources :favourite_projects, only: [ :new, :create, :destroy ]

    patch '/milestone/:id', to: 'milestones#status', as: "status_milestone"
  end

  get '/tagged', to: "projects#tagged", as: :tagged

  post '/project/:id/', to: "projects#media"

  get '/profile/:id', to: 'pages#profile', as: "profile"
  get '/dashboard/', to: 'pages#dashboard', as: "dashboard"
  get '/messages/', to: 'pages#messages', as: "messages"

  patch '/confirm/:id', to: 'collaborations#confirm', as: "confirm"
  patch '/confirm/:id', to: 'collaborations#deny', as: "deny"



  mount ActionCable.server => "/cable"
end
