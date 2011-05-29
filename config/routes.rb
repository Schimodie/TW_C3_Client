Contest3Client::Application.routes.draw do
  root :to => 'pages#home'

  match ':controller(/:action(/:id(.:format)))'
end
