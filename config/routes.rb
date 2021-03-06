Rails.application.routes.draw do
  # workaround to get the new sessions to load first
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get  'index', to: 'application#index'
  get  'search_apis', to: 'application#search_apis'

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' }

  resources :users, only: [:index, :show] do
    resources :bookmarks, shallow: true, except: [:new]
    resources :reminders, shallow: true
  end

  resources :friendships

end

# index PAGE
# show PAGE
# edit PAGE
# new PAGE
# create ACTION
# update ACTION
# destroy ACTION




