Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'auth/spotify/callback', to: 'spotify#callback'
  post 'auth/spotify/playlist' => 'spotify#playlist', as: :playlist
end
