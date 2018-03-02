Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/:url' => 'graphs#index'
  root to: 'graphs#index'

  namespace :api do
    namespace :v1 do
      post '/code' => 'codes#analyze'
      post '/save' => 'codes#save'
      get '/:url' => 'codes#show'
    end
  end
end
