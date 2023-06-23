Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
    delete 'users/guest_sign_out' => 'public/sessions#guest_sign_out'
  end

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do

    root 'posts#index'
    get 'about' => 'homes#about'

    get 'users/confirm' => 'users#confirm'
    patch 'users/quit' => 'users#quit'
    resources :users, only: %i[show] do
      get "/posts" => "users#posts"
    end

    get "/search" => "posts#search"

    # indexはルートパス設定済み
    resources :posts do
      resources :comments, only: %i[create update destroy]
      resource :bookmark, only: %i[create destroy]
    end

    resources :folders, except: %i[edit new index]
  end

  namespace :admin do
    root 'users#index'
    resources :areas, only: %i[index create update]
    resources :users, only: %i[index show edit update] do
      get "/posts" => "users#posts"
      get "/comments" => "users#comments"
    end

    resources :posts, only: %i[index show] do
      resources :comments, only: %i[destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
