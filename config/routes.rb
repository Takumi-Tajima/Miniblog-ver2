Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts, only: %i[index show]

  scope module: :users do
    resources :posts, only: %i[new create]
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
