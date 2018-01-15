Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'graphs#index'

  namespace :api do
    namespace :v1 do
      post '/code' => 'codes#analyze'
    end
  end
end
