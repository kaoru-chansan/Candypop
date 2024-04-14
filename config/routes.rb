Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

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

  get 'customers/show'
  get 'customers/edit'
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
