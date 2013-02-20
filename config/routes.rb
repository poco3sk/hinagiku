Hinagiku::Application.routes.draw do
  root to: "tasks#index"
  resources :tasks do
    put :finish, on: :member
    get :done, on: :collection
  end
end
