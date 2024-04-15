Rails.application.routes.draw do

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

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
  get 'post_lists/index'
  get 'post_lists/show'
  get 'homes/top'
  get 'homes/admout'
  
  resources :post_losts, only: [:index, :show]

  get 'customers/my_page', to: 'customers#show', as: 'customers_show'
  get 'customers/information/edit', to: 'customers#edit', as: 'customers_edit'
  patch 'customers/information', to: 'customers#update'
  get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'customers_unsubscribe'
  patch 'customers/withdraw', to: 'customers#withdraw'

  # scope(path_names: { show: 'my_page', edit: 'information/edit', update: 'information' })
  #   resources :customer, path: 'customers'

  get 'customers/unsubscribe'

  get 'posts/show'
  get 'posts/edit'
  get 'posts/new'
  get 'posts/index'

  get 'relationships/followings'
  get 'relationships/followers'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
