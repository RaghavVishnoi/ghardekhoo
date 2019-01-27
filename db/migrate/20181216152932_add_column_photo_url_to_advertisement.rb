class AddColumnPhotoUrlToAdvertisement < ActiveRecord::Migration[5.0]
  def change
  	remove_column :retailer_photos, :ad_photo
  	add_column :advertisements, :photo_url, :string
  end
end
