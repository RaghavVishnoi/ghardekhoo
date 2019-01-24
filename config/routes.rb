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
          end
        end

      end
  end

  devise_for :retailers
  devise_for :employees
  resources :retailers do
    collection do
      get 'search' => 'retailers#search'
    end
  end
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
