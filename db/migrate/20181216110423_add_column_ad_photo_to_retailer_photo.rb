class AddColumnAdPhotoToRetailerPhoto < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailer_photos, :ad_photo, :boolean, default: false
  end
end
