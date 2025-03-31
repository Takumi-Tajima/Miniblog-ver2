Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  scope module: :users do
    resources :posts, only: %i[new edit create update destroy]
    resource :profile, only: %i[show edit update]
    resource :following_posts, only: %i[show]
  end

  resources :users, only: [] do
    member do
      post :follow, to: 'users/relationships#create'
      delete :unfollow, to: 'users/relationships#destroy'
    end
  end

  resources :posts, only: %i[show]
  resources :users, only: %i[show]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
