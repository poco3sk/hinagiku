Hinagiku::Application.routes.draw do
  get "tasks/index"
  resource :tasks
end
