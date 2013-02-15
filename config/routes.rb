Hinagiku::Application.routes.draw do
  root to: "tasks#index"
  resource :tasks
end
