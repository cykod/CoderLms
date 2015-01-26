Rails.application.routes.draw do

  mount LittleBigAdmin::Engine => "/admin"

  get '/auth/:provider/callback', to: 'user_sessions#create'
  resource :user_sessions, only: :destroy

  resources :sessions, path: "", only: [ :show, :create ] do
    resources :lessons do
      resources :pages, only: [ :show, :create, :update, :destroy ] do
        resources :page_files, only: [ :new, :create, :update, :destroy ] do
          put :up
          put :down
        end
        resource :user_pages, only: [ :update ]
        get ":username/*id" => "user_page_files#show", as: "user_page_file", format: false
      end
    end

  end
  
  
  root to: "home#index"
end

