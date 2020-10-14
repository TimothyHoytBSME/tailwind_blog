Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get 'home' => 'posts#index', as:'home'
  get 'about' => 'pages#about', as:'about'
  get 'new' => 'posts#new', as:'new'
  resources :posts do
    resources :comments
    member do
      put "like" => "posts#vote"
    end
  end
  #devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'  }
end
