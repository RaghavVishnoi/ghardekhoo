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
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    collection :upload_retailers do
      only ['Retailer']
      link_icon 'fa fa-upload'
    end

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

  config.excluded_models = [ Admin]

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
                   :retailer_photos

  end

end
