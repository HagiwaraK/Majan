Rails.application.routes.draw do
  get 'summary/show'
  post 'result/show'
  get 'welcome/index'
  post 'start/master' => 'start#master'
  post 'start/next_game' => 'start#next_game'

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
