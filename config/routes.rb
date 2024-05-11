Rails.application.routes.draw do

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end


  devise_for :admin, skip: [:registrations, :password], controllers: {
  sessions: "admin/sessions"
  }

# 管理者
  namespace :admin do
    resources :customers, only: [:index, :show, :edit]
    patch 'customers/withdraw/:id', to: 'customers#withdraw', as: 'withdraw'
  end

# 顧客
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
  get 'customers/:customer_id/favorites', to: 'customers#favorites', as: 'customers_favorites'
  post 'customers/:customer_id/relationships', to: 'relationships#create', as: 'follow'
  delete 'customers/:customer_id/relationships', to: 'relationships#destroy', as: 'unfollow'
  get 'customers/:customer_id/relationships/followings', to: 'relationships#followings', as: 'followings'
  get 'customers/:customer_id/relationships/followers', to: 'relationships#followers', as: 'followers'
  get "search", to: "searches#search_result", as: 'search'

  resources :posts, only: [:new, :show, :edit, :index, :destroy, :create, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
