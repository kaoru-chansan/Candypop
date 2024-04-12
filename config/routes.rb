Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  namespace :public do
    get 'posts/show'
    get 'posts/edit'
    get 'posts/new'
    get 'posts/index'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/unsubscribe'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  devise_for :admins
  devise_for :customers
  get 'post_lists/index'
  get 'post_lists/show'
  get 'homes/top'
  get 'homes/admout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
