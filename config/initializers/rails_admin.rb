require Rails.root.join('lib', 'upload_photo.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::UploadPhoto)


RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['RetailerPhoto', 'RetailerProductPhoto']
    end
    export
    bulk_delete
    show
    edit do
      except ['RetailerProductPhoto', 'Advertisement', 'UserRequestReply']
    end
    upload_photo do
      only ['Retailer', 'RetailerProduct', 'Advertisement']
      link_icon 'fa fa-upload'
    end
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # hidden filed configuration start
  # pass the array of fields you want to hide. This is to ovveride rails admin default
  # where they hide created_at and updated_at also. Here we ourself listing the hidden field
  config.default_hidden_fields = {
    show: [:id],
    edit: [:id, :created_at, :updated_at]
  }

  # remove fileds with nil value from show mode. set it to false if you want to show empty fields
  config.compact_show_view = true

  config.excluded_models = [ Admin ]

  # Hide unused fields from user model
  config.model 'Employee' do
    exclude_fields :unlock_token,
                   :reset_password_sent_at,
                   :remember_created_at,
                   :failed_attempts,
                   :locked_at,
                   :confirmation_token,
                   :confirmed_at,
                   :confirmation_sent_at,
                   :unconfirmed_email,
                   :login_histories,
                   :employee_roles
  end

  config.model 'ProductCategory' do
    exclude_fields :retailers,
                   :retailer_product_categories
  end

  config.model 'Retailer' do
    exclude_fields :unlock_token,
                   :reset_password_sent_at,
                   :remember_created_at,
                   :failed_attempts,
                   :locked_at,
                   :confirmation_token,
                   :confirmed_at,
                   :confirmation_sent_at,
                   :unconfirmed_email,
                   :login_histories,
                   :employee_roles,
                   :retailer_product_categories,
                   :product_categories,
                   :retailer_products,
                   :retailer_photos,
                   :advertisements,
                   :retailer_reviews,
                   :password,
                   :password_confirmation,
                   :photo_url,
                   :lat,
                   :lng,
                   :employee
    include_fields :first_name,
                   :last_name,
                   :email,
                   :phone,
                   :state,
                   :city,
                   :address,
                   :gst_number,
                   :adhaar_number,
                   :pan_number,
                   :employee_id,
                   :active,
                   :account_type,
                   :account_status,
                   :username,
                   :about_business,
                   :rating
    create do
      field :city do
        partial "city"
      end
      exclude_fields :username,
                     :rating,
                     :password,
                     :password_confirmation,
                     :photo_url,
                     :unlock_token,
                     :reset_password_sent_at,
                     :remember_created_at,
                     :failed_attempts,
                     :locked_at,
                     :confirmation_token,
                     :confirmed_at,
                     :confirmation_sent_at,
                     :unconfirmed_email,
                     :login_histories,
                     :employee_roles,
                     :retailer_product_categories,
                     :product_categories,
                     :retailer_products,
                     :retailer_photos,
                     :advertisements,
                     :retailer_reviews,
                     :country,
                     :lat,
                     :lng,
                     :photos,
                     :token,
                     :employee
    end 

    edit do
      field :city do
        partial "city"
      end
      exclude_fields :username,
                     :rating,
                     :password,
                     :password_confirmation,
                     :photo_url,
                     :unlock_token,
                     :reset_password_sent_at,
                     :remember_created_at,
                     :failed_attempts,
                     :locked_at,
                     :confirmation_token,
                     :confirmed_at,
                     :confirmation_sent_at,
                     :unconfirmed_email,
                     :login_histories,
                     :employee_roles,
                     :retailer_product_categories,
                     :product_categories,
                     :retailer_products,
                     :retailer_photos,
                     :advertisements,
                     :retailer_reviews,
                     :country,
                     :lat,
                     :lng,
                     :photos,
                     :token,
                     :employee
    end 

    field :photos, :multiple_active_storage do 
      delete_method :delete_photos
    end

    show do
      include_fields :retailer_products
    end

  end

  config.model 'RetailerProduct' do
    exclude_fields :retailer_product_photos
    create do
      exclude_fields :photos
      field :city do
        partial "city"
      end
    end

    edit do
      exclude_fields :photos
      field :city do
        partial "city"
      end
    end

    configure :retailer_state do
      searchable [{Retailer => :state}]
      sortable true
      filterable true
      queryable true
    end

    configure :retailer_city do
      searchable [{Retailer => :city}]
      sortable true
      filterable true
      queryable true
    end

    configure :is_retailer_active do
      searchable [{Retailer => :active}]
      sortable true
      filterable true
      queryable true
    end

    list do
      include_fields :retailer_state, :retailer_city, :is_retailer_active
    end
  end

  config.model 'Advertisement' do
    exclude_fields :photo_url, :retailer, :attachment
    fields :ad_type_id, :photos, :active

    create do
      exclude_fields :photos
    end

    edit do
      exclude_fields :photos
    end
  end

  config.model 'AdType' do
    exclude_fields :advertisements
  end

  config.model 'ProductSubCategory' do
    exclude_fields :name, :retailer_products
    create do
      fields :p_name, :active, :product_category_id
    end
  end

  config.model 'RetailerPhoto' do
    list do
      field :photo do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].photo_url })
        end
      end
      fields :photo_url, :retailer, :main
    end

    show do
      field :photo do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].photo_url })
        end
      end
      fields :photo_url, :retailer, :main
    end
  end

  config.model 'RetailerProductPhoto' do
    list do
      field :photo do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].photo_url })
        end
      end
      fields :photo_url, :retailer_product
    end

    show do
      field :photo do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].photo_url })
        end
      end
      fields :photo_url, :retailer_product
    end
  end

  config.model 'UserRequest' do
    list do
      exclude_fields :user_request_replies, :product_category, :active
      configure :status do
        searchable true
        queryable false
      end
      configure :product_sub_category do
        searchable [{ProductSubCategory => :p_name}]
      end
      fields :number, :subject, :description, :status, :product_sub_category, :user
    end

    show do
      exclude_fields :product_category, :active
    end

    edit do
      exclude_fields :user_request_replies, :product_category, :active, :product_sub_category, :subject, :description, :user, :number
    end
  end

  config.model 'UserRequestReply' do
    create do
      exclude_fields :user, :replied_by
    end

    edit do
      exclude_fields :user, :replied_by
    end
  end



end
