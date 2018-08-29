Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :large_groups
  resources :cell_groups
  resources :members
  resources :member_dgs
  resources :discussion_groups

  root 'home#index', as: 'home'

  get 'login', to: 'sessions#new', as: :login

  # custom routes
  get 'settings', to: 'users#settings', as: 'settings'
  get 'large_groups/:id/shuffle', to: 'large_groups#shuffle', as: 'shuffle'
  get 'large_groups/:id/reset', to: 'large_groups#reset', as: 'reset'
  get '/add_or_reassign/:id', to: 'large_groups#add_or_reassign', as: 'add_or_reassign'
  post '/create_members_and_dg/:id', to: 'members#create_members_and_dg', as: :create_members_and_dg
end
