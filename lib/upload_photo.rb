require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminUploadPhoto
end

module RailsAdmin
   module Config
      module Actions
         class UploadPhoto < RailsAdmin::Config::Actions::Base
         RailsAdmin::Config::Actions.register(self)
         register_instance_option :controller do
            Proc.new do
               @retailer = Retailer.find_by(id: params[:id])
               render "upload_photos"
            end
         end
         register_instance_option :member do
          true
         end
         register_instance_option :link_icon do
            'fa fa-upload'
         end 
      end
    end
  end
end