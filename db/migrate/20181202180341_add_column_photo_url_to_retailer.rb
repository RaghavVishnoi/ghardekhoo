class AddColumnPhotoUrlToRetailer < ActiveRecord::Migration[5.0]
  def change
  	add_column :retailers, :photo_url, :string
  end
end
