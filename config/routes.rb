Rails.application.routes.draw do

  namespace :api do
      api_version(
        module: 'V1',
        header: { name: 'Accept', value: 'application/vnd.ghardekhoo-retailers.com; version=1' },
        default: { format: :json }
      ) do

        devise_for :retailers, controllers: {sessions: "api/retailers/v1/sessions", registrations: "api/retailers/v1/registrations"}
        resources :product_categories, only: [:index]
        resources :retailer_products, only: [:create, :destroy]
        post 'product/:id/update' => 'retailer_products#update'
        get '/product/:id' => 'retailer_products#show'
        get '/products' => 'retailer_products#index'
        get '/retailer_profile' => 'retailers#show'
        get '/retailer_app_banner' => 'retailers#banner'
        post '/retailers/add_account_type' => 'retailers#add_account_type'

        resources :retailers do
          collection do
            post 'update' => 'retailers#update'
          end
        end

      end
  end

  namespace :api do
      api_version(
        module: 'V1',
        header: { name: 'Accept', value: 'application/vnd.ghardekhoo.com; version=1' },
        default: { format: :json }
      ) do

        devise_for :users, controllers: {sessions: "api/users/v1/sessions", registrations: "api/users/v1/registrations"}
        resources :users do
          collection do
            post 'update' => 'users#update'
            post '/search_retailers' => 'users#search'
          end
        end

        get '/user_app_banner' => 'users#banner'

      end
  end

  get '/free_listing' => 'retailers#new'
  get '/advertise' => 'retailers#new'
  get '/retailer_location' => 'retailers#location'
  post '/retailers_city_list' => 'retailers#state_cities'
  post '/set_location' => 'retailers#set_location'

  devise_for :retailers, controllers: {sessions: "retailers", registrations: "retailers"}
  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users"}

  devise_for :employees
  resources :retailers do
    collection do
      get 'search' => 'retailers#search'
    end
  end

  get '/retailers/:username' => 'retailers#show'
  get '/users/facebook_login' => 'users#facebook_login'
  get '/auth/google_oauth2/callback', to: 'users#google_login'
  post '/facebook_login' => 'users#facebook_login'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'	

  post '/city_list' => 'dropdowns#city_list'
  post '/get_location' => 'home#get_location'
  post '/city_retailers' => 'dropdowns#city_retailers'
  
  devise_for :admin, controllers: {sessions: "admin/sessions"}
  devise_scope :admin do
    delete '/admin/sign_out' => 'admin/sessions#destroy'
    post '/admin/retailer/upload_retailers' => 'retailers#upload'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
