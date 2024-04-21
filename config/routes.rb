Rails.application.routes.draw do

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
  # devise_for :customers, skip: [:passwords], controllers: {
  # registrations: "public/registrations",
  # sessions: 'public/sessions'
  # }

  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }


  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end

scope module: :public do
  root to: 'homes#top'
  get 'homes/admout'


  # resources :post_lists, only: [:index, :show]

  get 'customers', to: 'customers#index', as: 'customers_index'
  get 'customers/my_page/:id', to: 'customers#show', as: 'customers_show'
  get 'customers/information/edit/:id', to: 'customers#edit', as: 'customers_edit'
  patch 'customers/information/edit/:id', to: 'customers#update'
  get 'customers/unsubscribe/:id', to: 'customers#unsubscribe', as: 'unsubscribe'
  patch 'customers/withdraw/:id', to: 'customers#withdraw', as: 'withdraw'

  resources :posts, only: [:new, :show, :edit, :index, :destroy]

  get 'relationships/followings'
  get 'relationships/followers'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
