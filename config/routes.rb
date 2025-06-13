Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :companies, shallow: true do
    collection do
      get 'new', to: 'companies#new', as: :new
    end
    member do
      get 'edit', to: 'companies#edit', as: :edit
    end
    resources :users, only: [:index]
  end

  resources :tweets, only: [:index]

  resources :users, param: :username do
    resources :tweets, only: [:index]
  end

end
