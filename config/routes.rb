Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'games#show'
  root 'home#index'
  resources :games
  resources :pieces do
    collection do
    get :update 
    end 
  end

  get "/pieces/:rookid/castle_queen" => "pieces#castle_queen"
  get "/pieces/:rookid/castle_king" => "pieces#castle_king"
end
