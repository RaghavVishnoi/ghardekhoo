Rails.application.routes.draw do
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
