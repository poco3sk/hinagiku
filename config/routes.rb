Hinagiku::Application.routes.draw do
  get "categories/index"

  root to: "tasks#index"
  resources :tasks do
    put :finish, :restart, on: :member
    get :done, :search, on: :collection
  end

  resources :categories do
    resources :tasks, only: [:index] do
      get :done, on: :collection
    end
  end

  resource :session, only: [ :new, :create, :destroy ]

  match '*anything' => 'errors#not_found'
end
