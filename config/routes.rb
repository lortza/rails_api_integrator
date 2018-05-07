Rails.application.routes.draw do
  get '/reports/:state/:city', to: 'reports#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
