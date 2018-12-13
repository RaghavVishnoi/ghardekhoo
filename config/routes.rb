Rails.application.routes.draw do

  namespace :api do
      api_version(
        module: 'V1',
        header: { name: 'Accept', value: 'application/vnd.ghardekhoo-retailers.com; version=1' },
        default: { format: :json }
      ) do

        devise_for :retailers, controllers: {sessions: "api/retailers/v1/sessions", registrations: "api/retailers/v1/registrations"}
        resources :product_categories, only: [:index]
        resources :retailer_products, only: [:index, :show, :create]
        post 'product/:id/update' => 'retailer_products#update'

        resources :retailers do
          collection do
            post 'update' => 'retailers#update'
          end
        end

      end
  end

  devise_for :retailers
  devise_for :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'	

  devise_for :admin, controllers: {sessions: "admin/sessions"}
  devise_scope :admin do
    delete '/admin/sign_out' => 'admin/sessions#destroy'
    post '/admin/retailer/upload_retailers' => 'retailers#upload'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
