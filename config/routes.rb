Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do

    root 'posts#index'
    get 'about' => 'homes#about'

    get 'mypage' => 'users#show'
    get 'users/confirm' => 'users#confirm'
    patch 'users/quit' => 'users#quit'
    
    # indexはルートパス設定済み
    resources :posts, except: [:index] do
      resources :comments, only: %i[create update destroy]
      resource :bookmark, only: %i[create destroy]
    end
    
    resources :folders, except: %i[edit new]
  end
  
  namespace :admin do
    root 'users#index'
    resource :areas, only: %i[index create edit update]
    resources :users, only: %i[index show edit update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
