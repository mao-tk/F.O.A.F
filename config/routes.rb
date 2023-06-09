Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do

    root 'posts#index'
    get 'about' => 'homes#about'

    # get 'mypage' => 'users#show'
    get 'users/confirm' => 'users#confirm'
    patch 'users/quit' => 'users#quit'
    resources :users, only: %i[show] do
      get "/posts" => "users#posts"
    end

    # indexはルートパス設定済み
    resources :posts, only: %i[new create index show] do
      resources :comments, only: %i[create update destroy]
      resource :bookmark, only: %i[create destroy]
    end

    resources :folders, except: %i[edit new]
  end

  namespace :admin do
    root 'users#index'
    resource :areas, only: %i[new index create edit update]
    resources :users, only: %i[index show edit update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
