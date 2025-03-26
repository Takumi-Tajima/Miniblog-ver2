Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  scope module: :users do
    resources :posts, only: %i[new edit create update destroy]
  end

  resources :posts, only: %i[show]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
